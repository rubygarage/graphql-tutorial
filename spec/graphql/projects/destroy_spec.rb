require 'support/schemas/projects/destroy'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }
  let!(:project) { create :project, user: user }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($id: ID!) {
          projectDestroy(input: {
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
        { id: project.id }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'has errors' do
        expect(response).to match_schema(DestroyProjectSchema::NotAuthenticated)
        expect(response).to be_ok
      end
    end

    context 'authenticated' do
      before { sign_in user }

      context 'fail' do
        context 'wrong project id' do
          let(:variables) do
            { id: 0 }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(DestroyProjectSchema::NotFound)
            expect(response).to be_ok
          end
        end
      end

      context 'success' do
        let(:variables) do
          { id: project.id }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'destroy project' do
          expect(response).to match_schema(DestroyProjectSchema::Success)
          expect(response).to be_ok
        end
      end
    end
  end
end
