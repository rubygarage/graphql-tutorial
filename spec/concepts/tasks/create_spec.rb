RSpec.describe Tasks::Create do
  let(:user) { create :user }
  let(:project) { create :project, user: user }

  describe 'Failure' do
    context 'project not found' do
      subject { described_class.call(params: { project_id: 0 }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'invalid params' do
      let(:params) { { project_id: project.id, name: '' } }

      subject { described_class.call(params: params, current_user: user) }

      let(:error) { { name: ['must be filled'] } }

      it 'has validation error' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match error
      end
    end
  end

  describe 'Success' do
    let(:params) { { project_id: project.id, name: FFaker::DizzleIpsum.word } }

    subject { described_class.call(params: params, current_user: user) }

    it 'creates task' do
      expect { subject }.to change(user.tasks, :count).from(0).to(1)
      expect(subject[:model].name).to eq params[:name]
      expect(subject[:model].position).to eq 0
      expect(subject).to be_success
    end

    context 'updates position of created tasks' do
      let!(:task) { create :task, project: project, position: 0 }

      it 'updates position' do
        expect { subject }.to change { task.reload.position }
          .from(task.position).to(task.position + 1)
        expect(subject).to be_success
      end
    end
  end
end
