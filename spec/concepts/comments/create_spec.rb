RSpec.describe Comments::Create do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:task) { create :task, project: project }

  describe 'Failure' do
    context 'task not found' do
      subject { described_class.call(params: { task_id: 0 }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'invalid params' do
      subject { described_class.call(params: { task_id: task.id, body: '' }, current_user: user) }

      let(:error) { { body: ['must be filled'] } }

      it 'has validation error' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match error
      end
    end
  end

  describe 'Success' do
    let(:params) do
      {
        task_id: task.id,
        body: FFaker::DizzleIpsum.paragraph,
        attachment: fixture_file_upload('files/avatar.png', 'image/png')
      }
    end

    subject { described_class.call(params: params, current_user: user) }

    it 'creates comment' do
      expect { subject }.to change(user.comments, :count).from(0).to(1)
      expect(subject).to be_success
      expect(subject[:model].body).to eq params[:body]
      expect(subject[:model].attachment_url).not_to be_nil
    end
  end
end
