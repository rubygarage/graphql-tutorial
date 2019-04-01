require 'support/schemas/users/show'

RSpec.describe GraphqlsController, type: :controller do
  let(:user) { create :user }

  describe 'POST #create' do
    let(:query) do
      '
        query($id: ID!) {
          user(id: $id) {
            id
            email
            createdAt
            updatedAt
          }
        }
      '
    end

    context 'fail' do
      context 'wrong user id' do
        let(:variables) do
          { id: 0 }
        end

        before { post :create, params: { query: query, variables: variables } }

        it 'has errors' do
          expect(response).to match_schema(ShowUserSchema::NotFound)
          expect(response).to be_ok
        end
      end
    end

    context 'success' do
      let(:variables) do
        { id: user.id }
      end

      before { post :create, params: { query: query, variables: variables } }

      it 'show user' do
        expect(response).to match_schema(ShowUserSchema::Success)
        expect(response).to be_ok
      end
    end
  end
end
