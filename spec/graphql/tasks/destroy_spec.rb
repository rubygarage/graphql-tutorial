require 'support/schemas/tasks/destroy'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let!(:task) { create :task, project: project }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($id: ID!) {
          destroyTask(input: {
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
        { id: task.id }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'has errors' do
        expect(response).to match_schema(DestroyTaskSchema::NotAuthenticated)
        expect(response).to be_ok
      end
    end

    context 'authenticated' do
      before { sign_in user }

      context 'fail' do
        context 'wrong task id' do
          let(:variables) do
            { id: 0 }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(DestroyTaskSchema::NotFound)
            expect(response).to be_ok
          end
        end
      end

      context 'success' do
        let(:variables) do
          { id: task.id }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'destroy task' do
          expect(response).to match_schema(DestroyTaskSchema::Success)
          expect(response).to be_ok
        end
      end
    end
  end
end
