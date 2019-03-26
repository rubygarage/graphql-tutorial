require 'support/schemas/tasks/update'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let!(:task) { create :task, project: project }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($id: ID!, $name: String, $done: Boolean) {
          taskUpdate(input: {
            id: $id,
            name: $name,
            done: $done
          }) {
            task {
              id
              name
              done
              projectId
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
          id: task.id,
          name: '',
          done: true
        }
      end

      before { post :create, params: { query: mutation, variables: variables }, as: :json }

      it 'has errors' do
        expect(response).to match_schema(UpdateTaskSchema::NotAuthenticated)
        expect(response).to be_ok
      end
    end

    context 'authenticated' do
      before { sign_in user }

      context 'fail' do
        context 'wrong task id' do
          let(:variables) do
            {
              id: 0,
              name: '',
              done: true
            }
          end

          before { post :create, params: { query: mutation, variables: variables }, as: :json }

          it 'has errors' do
            expect(response).to match_schema(UpdateTaskSchema::NotFound)
            expect(response).to be_ok
          end
        end

        context 'invalid params' do
          let(:variables) do
            {
              id: task.id,
              name: ''
            }
          end

          before { post :create, params: { query: mutation, variables: variables }, as: :json }

          it 'has errors' do
            expect(response).to match_schema(UpdateTaskSchema::Error)
            expect(response).to be_ok
          end
        end
      end

      context 'success' do
        let(:variables) do
          {
            id: task.id,
            name: FFaker::DizzleIpsum.word,
            done: true
          }
        end

        before { post :create, params: { query: mutation, variables: variables }, as: :json }

        it 'update task' do
          expect(response).to match_schema(UpdateTaskSchema::Success)
          expect(response).to be_ok
        end
      end
    end
  end
end
