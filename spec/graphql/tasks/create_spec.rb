require 'support/schemas/tasks/create'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }
  let(:project) { create :project, user: user }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($projectId: ID!, $name: String!) {
          createTask(input: {
            projectId: $projectId,
            name: $name
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
          projectId: 0,
          name: ''
        }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'has errors' do
        expect(response).to match_schema(CreateTaskSchema::NotAuthenticated)
        expect(response).to be_ok
      end
    end

    context 'authenticated' do
      before { sign_in user }

      context 'fail' do
        context 'wrong task id' do
          let(:variables) do
            {
              projectId: 0,
              name: ''
            }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(CreateTaskSchema::ProjectNotFound)
            expect(response).to be_ok
          end
        end

        context 'invalid params' do
          let(:variables) do
            {
              projectId: project.id,
              name: ''
            }
          end

          before { post :create, params: { query: mutation, variables: variables } }

          it 'has errors' do
            expect(response).to match_schema(CreateTaskSchema::Error)
            expect(response).to be_ok
          end
        end
      end

      context 'success' do
        let(:variables) do
          {
            projectId: project.id,
            name: FFaker::DizzleIpsum.word
          }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'create project' do
          expect(response).to match_schema(CreateTaskSchema::Success)
          expect(response).to be_ok
        end
      end
    end
  end
end
