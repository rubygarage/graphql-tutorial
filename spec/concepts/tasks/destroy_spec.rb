RSpec.describe Tasks::Destroy do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let!(:task) { create :task, project: project }

  describe 'Failure' do
    context 'task not found' do
      subject { described_class.call(params: { id: 0 }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'delete task of another user' do
      let(:another_user) { create :user }
      let(:another_project) { create :project, user: another_user }
      let(:another_task) { create :task, project: another_project }

      subject { described_class.call(params: { id: another_task.id }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe 'Success' do
    subject { described_class.call(params: { id: task.id }, current_user: user) }

    it 'deletes task' do
      expect { subject }.to change(user.tasks, :count).from(1).to(0)
      expect(subject).to be_success
    end
  end
end
