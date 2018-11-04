require 'support/schemas/comments/create'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:task) { create :task, project: project }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($taskId: ID!, $body: String!, $attachment: Upload) {
          createComment(input: {
            body: $body,
            taskId: $taskId,
            attachment: $attachment
          }) {
            comment {
              id
              body
              attachmentUrl
              taskId
              createdAt
              updatedAt
            },
            errors {
              messages,
              path
            }
          }
        }
      '
    end

    context 'unauthenticated' do
      let(:variables) do
        {
          taskId: 0,
          body: ''
        }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'has errors' do
        expect(response).to match_schema(CreateCommentSchema::NotAuthenticated)
        expect(response).to be_ok
      end
    end

    context 'authenticated' do
      before { sign_in user }

      context 'fail' do
        context 'wrong task id' do
          let(:variables) do
            {
              taskId: 0,
              body: ''
            }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(CreateCommentSchema::TaskNotFound)
            expect(response).to be_ok
          end
        end

        context 'invalid params' do
          let(:variables) do
            {
              taskId: task.id,
              body: ''
            }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(CreateCommentSchema::Error)
            expect(response).to be_ok
          end
        end
      end

      context 'success' do
        let(:variables) do
          {
            taskId: task.id,
            body: FFaker::DizzleIpsum.paragraph,
            attachment: fixture_file_upload('files/avatar.png', 'image/png')
          }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'create comment' do
          expect(response).to match_schema(CreateCommentSchema::Success)
          expect(response).to be_ok
        end
      end
    end
  end
end
