RSpec.describe Task, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:done).of_type(:boolean) }
    it { is_expected.to have_db_column(:position).of_type(:integer) }
  end

  context 'relations' do
    it { is_expected.to belong_to(:project) }
  end
end
