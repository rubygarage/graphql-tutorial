RSpec.describe Users::Create do
  describe 'Failure' do
    context 'invalid params' do
      let(:params) { { email: '', password: '' } }

      subject { described_class.call(params: params) }

      let(:errors) do
        {
          email: ['must be filled'],
          password: ['must be filled', 'size cannot be less than 6']
        }
      end

      it 'has validation error' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match errors
      end
    end

    context 'password confirmation does not match password' do
      let(:params) do
        {
          email: FFaker::Internet.email,
          password: FFaker::Internet.password,
          password_confirmation: 'password'
        }
      end

      subject { described_class.call(params: params) }

      let(:error) { { password_confirmation: ["Password confirmation doesn't match"] } }

      it 'has validation error' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match error
      end
    end

    context 'email is not unique' do
      let!(:user) { create(:user) }
      let(:params) do
        {
          email: user.email,
          password: 'password',
          password_confirmation: 'password'
        }
      end

      subject { described_class.call(params: params) }

      let(:error) { { email: ['This email is already registered.'] } }

      it 'has validation error' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match error
      end
    end
  end

  describe 'Success' do
    let(:params) do
      {
        email: FFaker::Internet.email,
        password: 'password',
        password_confirmation: 'password'
      }
    end

    subject { described_class.call(params: params) }

    it 'creates project' do
      expect { subject }.to change(User, :count).from(0).to(1)
      expect(subject[:model].email).to eq params[:email]
      expect(subject).to be_success
    end
  end
end
