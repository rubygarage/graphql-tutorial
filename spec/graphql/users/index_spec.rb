require 'support/schemas/users/index'

RSpec.describe GraphqlsController, type: :controller do
  let!(:users) { create_list(:user, 2) }

  describe 'POST #create' do
    let(:query) do
      '
        query {
          users {
            id
            email
            createdAt
            updatedAt
          }
        }
      '
    end

    context 'success' do
      before { post :create, params: { query: query } }

      it 'returns users' do
        expect(response).to match_schema(IndexUsersSchema::Success)
        expect(response).to be_ok
      end
    end
  end
end
