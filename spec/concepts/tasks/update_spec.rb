RSpec.describe Tasks::Update do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let!(:task) { create :task, project: project }

  describe 'Failure' do
    context 'task not found' do
      subject { described_class.call(params: { id: 0 }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'update task of another user' do
      let(:another_user) { create :user }
      let(:another_project) { create :project, user: another_user }
      let(:another_task) { create :task, project: another_project }

      subject { described_class.call(params: { id: another_task.id }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'invalid params' do
      let(:params) { { id: task.id, name: '', done: '', position: -2 } }

      subject { described_class.call(params: params, current_user: user) }

      let(:errors) do
        {
          position: ['must be greater than or equal to 0'],
          name: ['must be filled'],
          done: ['must be filled']
        }
      end

      it 'has validation error' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match errors
      end
    end
  end

  describe 'Success' do
    subject { described_class.call(params: params, current_user: user) }

    context 'main params' do
      let(:params) { { id: task.id, name: FFaker::DizzleIpsum.word, position: 3 } }

      it 'updates project' do
        expect { subject }.to not_change(user.tasks, :count)
        expect(subject[:model].name).to eq params[:name]
        expect(subject[:model].position).to eq params[:position]
        expect(subject).to be_success
      end
    end

    context 'complete task' do
      let(:params) { { id: task.id, done: true } }

      it 'updates project' do
        expect { subject }.to not_change(user.projects, :count)
        expect(subject[:model].done).to be_truthy
        expect(subject).to be_success
      end
    end
  end
end
