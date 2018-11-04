RSpec.describe Projects::Update do
  let(:user) { create :user }
  let!(:project) { create :project, user: user }

  describe 'Failure' do
    context 'project not found' do
      subject { described_class.call(params: { id: 0 }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'update project of another user' do
      let(:another_user) { create :user }
      let(:another_project) { create :project, user: another_user }

      subject { described_class.call(params: { id: another_project.id }, current_user: user) }

      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'invalid params' do
      let(:params) { { id: project.id, title: '', position: -2 } }

      subject { described_class.call(params: params, current_user: user) }

      let(:errors) do
        {
          position: ['must be greater than or equal to 0'],
          title: ['must be filled']
        }
      end

      it 'has validation error' do
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to match errors
      end
    end
  end

  describe 'Success' do
    let(:params) { { id: project.id, title: FFaker::DizzleIpsum.word, position: 3 } }

    subject { described_class.call(params: params, current_user: user) }

    it 'updates project' do
      expect { subject }.to not_change(user.projects, :count)
      expect(subject[:model].title).to eq params[:title]
      expect(subject[:model].position).to eq params[:position]
      expect(subject).to be_success
    end
  end
end
