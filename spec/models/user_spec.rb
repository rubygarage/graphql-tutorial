RSpec.describe User, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string) }
  end

  context 'relations' do
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_many(:tasks).through(:projects) }
    it { is_expected.to have_many(:comments).through(:tasks) }
  end
end
