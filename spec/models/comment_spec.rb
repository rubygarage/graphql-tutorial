RSpec.describe Comment, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_column(:attachment).of_type(:string) }
  end

  context 'relations' do
    it { is_expected.to belong_to(:task) }
  end
end
