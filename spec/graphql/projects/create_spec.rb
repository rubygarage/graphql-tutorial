require 'support/schemas/projects/create'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($title: String!) {
          projectCreate(input: {
            title: $title
          }) {
            project {
              id,
              title
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
        { title: '' }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'has errors' do
        expect(response).to match_schema(CreateProjectSchema::NotAuthenticated)
        expect(response).to be_ok
      end
    end

    context 'authenticated' do
      before { sign_in user }

      context 'fail' do
        context 'invalid params' do
          let(:variables) do
            { title: '' }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(CreateProjectSchema::Error)
            expect(response).to be_ok
          end
        end
      end

      context 'success' do
        let(:variables) do
          { title: FFaker::DizzleIpsum.word }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'create project' do
          expect(response).to match_schema(CreateProjectSchema::Success)
          expect(response).to be_ok
        end
      end
    end
  end
end
