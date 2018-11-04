RSpec.describe Projects::Destroy do
  let(:user) { create :user }
  let!(:project) { create :project, user: user }

  describe 'Failure' do
    context 'project not found' do
      subject { described_class.call(params: { id: 0 }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'delete project of another user' do
      let(:another_user) { create :user }
      let(:another_project) { create :project, user: another_user }

      subject { described_class.call(params: { id: another_project.id }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe 'Success' do
    subject { described_class.call(params: { id: project.id }, current_user: user) }

    it 'deletes project' do
      expect { subject }.to change(user.projects, :count).from(1).to(0)
      expect(subject).to be_success
    end
  end
end
