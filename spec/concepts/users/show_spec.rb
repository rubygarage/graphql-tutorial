RSpec.describe Users::Show do
  context 'failure' do
    context 'user not found' do
      subject { described_class.call(params: { id: 0 }) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  context 'success' do
    context 'valid params for existing user' do
      let(:user) { create(:user) }

      subject { described_class.call(params: { id: user.id }) }

      it 'returns user' do
        expect(subject[:model]).to eq user
        expect(subject).to be_success
      end
    end
  end
end
