RSpec.describe Users::Index do
  context 'success' do
    context 'valid params for existing user' do
      let!(:users) { create_list(:user, 2) }

      subject { described_class.call }

      it 'returns user' do
        expect(subject[:model]).to match_array users
        expect(subject).to be_success
      end
    end
  end
end
