require 'support/schemas/projects/update'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }
  let!(:project) { create :project, user: user }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($id: ID!, $title: String!) {
          projectUpdate(input: {
            id: $id,
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
        {
          id: project.id,
          title: ''
        }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'has errors' do
        expect(response).to match_schema(UpdateProjectSchema::NotAuthenticated)
        expect(response).to be_ok
      end
    end

    context 'authenticated' do
      before { sign_in user }

      context 'fail' do
        context 'wrong project id' do
          let(:variables) do
            {
              id: 0,
              title: ''
            }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(UpdateProjectSchema::NotFound)
            expect(response).to be_ok
          end
        end

        context 'invalid params' do
          let(:variables) do
            {
              id: project.id,
              title: ''
            }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(UpdateProjectSchema::Error)
            expect(response).to be_ok
          end
        end
      end

      context 'success' do
        let(:variables) do
          {
            id: project.id,
            title: FFaker::DizzleIpsum.word
          }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'update project' do
          expect(response).to match_schema(UpdateProjectSchema::Success)
          expect(response).to be_ok
        end
      end
    end
  end
end
