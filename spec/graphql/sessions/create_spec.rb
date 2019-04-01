require 'support/schemas/sessions/create'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }

  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($email: String!, $password: String!) {
          sessionCreate(input: {
            email: $email,
            password: $password,
          }) {
            user {
              id,
              email
            },
            token,
            errors {
              messages,
              path
            }
          }
        }
      '
    end

    context 'fail' do
      context 'user not found' do
        let(:variables) do
          {
            email: FFaker::Internet.email,
            password: FFaker::Internet.password
          }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'has errors' do
          expect(response).to match_schema(CreateSessionSchema::NotFound)
          expect(response).to be_ok
        end
      end

      context 'wrong password' do
        let(:variables) do
          {
            email: user.email,
            password: FFaker::Internet.password
          }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'has errors' do
          expect(response).to match_schema(CreateSessionSchema::WrongPassword)
          expect(response).to be_ok
        end
      end
    end

    context 'success' do
      let(:variables) do
        {
          email: user.email,
          password: user.password
        }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'create session' do
        expect(response).to match_schema(CreateSessionSchema::Success)
        expect(response).to be_ok
      end
    end
  end
end
