RSpec.describe Project, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:position).of_type(:integer) }
  end

  context 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tasks) }
  end
end
