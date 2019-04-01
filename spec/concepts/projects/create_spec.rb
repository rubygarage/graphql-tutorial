RSpec.describe Projects::Create do
  let(:user) { create :user }

  describe 'Failure' do
    context 'invalid params' do
      subject { described_class.call(params: { title: '' }, current_user: user) }

      let(:error) { { title: ['must be filled'] } }

      it 'has validation error' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match error
      end
    end
  end

  describe 'Success' do
    let(:params) { { title: FFaker::DizzleIpsum.word } }

    subject { described_class.call(params: params, current_user: user) }

    it 'creates project' do
      expect { subject }.to change(user.projects, :count).from(0).to(1)
      expect(subject[:model].title).to eq params[:title]
      expect(subject[:model].position).to eq user.projects.where.not(id: subject[:model].id).count
      expect(subject).to be_success
    end
  end
end
