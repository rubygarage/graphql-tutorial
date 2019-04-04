RSpec.describe Sessions::Create do
  context 'failure' do
    context 'invalid params' do
      subject { described_class.call(params: { wrong: 'param' }) }

      let(:errors) { { email: ['must be filled'], password: ['must be filled'] } }

      it 'has validation errors' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match errors
      end
    end

    context 'valid params without user' do
      let(:params) { { email: FFaker::Internet.email, password: FFaker::Internet.password } }

      subject { described_class.call(params: params) }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'valid params with user but wrong password' do
      let(:params) { { email: user.email, password: FFaker::Internet.password } }
      let!(:user) { create(:user) }

      subject { described_class.call(params: params) }

      it 'operation is failed' do
        expect(subject).to be_failure
      end
    end
  end

  context 'success' do
    let(:jwt_params) { { aud: 'user_auth', sub: user.id, exp: be_kind_of(Integer) } }
    let(:secret) { Rails.application.secret_key_base }

    context 'valid params for existing user' do
      let(:user) { create(:user) }
      let(:params) { { email: user.email, password: user.password } }

      subject { described_class.call(params: params) }

      it 'is authenticate and creates token' do
        expect(JWT).to receive(:encode).with(jwt_params, secret).and_call_original
        expect(subject[:token]).not_to be_empty
        expect(subject).to be_success
      end
    end
  end
end
