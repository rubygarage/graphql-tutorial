RSpec.describe Comments::Destroy do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:task) { create :task, project: project }
  let!(:comment) { create :comment, task: task }

  describe 'Failure' do
    context 'comment not found' do
      subject { described_class.call(params: { id: 0 }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'delete comment of another user' do
      let(:another_user) { create :user }
      let(:another_project) { create :project, user: another_user }
      let(:another_task) { create :task, project: another_project }
      let(:another_comment) { create :comment, task: another_task }

      subject { described_class.call(params: { id: another_comment.id }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe 'Success' do
    subject { described_class.call(params: { id: comment.id }, current_user: user) }

    it 'deletes comment' do
      expect { subject }.to change(user.comments, :count).from(1).to(0)
      expect(subject).to be_success
    end
  end
end
