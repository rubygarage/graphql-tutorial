require 'support/schemas/comments/destroy'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:task) { create :task, project: project }
  let!(:comment) { create :comment, task: task }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($id: ID!) {
          destroyComment(input: {
            id: $id
          }) {
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
        { id: 0 }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'has errors' do
        expect(response).to match_schema(DestroyCommentSchema::NotAuthenticated)
        expect(response).to be_ok
      end
    end

    context 'authenticated' do
      before { sign_in user }

      context 'fail' do
        context 'wrong comment id' do
          let(:variables) do
            { id: 0 }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(DestroyCommentSchema::NotFound)
            expect(response).to be_ok
          end
        end
      end

      context 'success' do
        let(:variables) do
          { id: comment.id }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'destroy comment' do
          expect(response).to match_schema(DestroyCommentSchema::Success)
          expect(response).to be_ok
        end
      end
    end
  end
end
