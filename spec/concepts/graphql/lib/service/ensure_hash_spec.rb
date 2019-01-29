RSpec.describe Graphql::Lib::Service::EnsureHash do
  subject { described_class.call(params) }

  context 'string' do
    let(:hash) { { 'title' => 'example glossary' } }
    let(:params) { hash.to_json }

    it 'returns hash' do
      expect(subject).to eq hash
    end
  end

  context 'hash' do
    let(:hash) { { 'title' => 'example glossary' } }
    let(:params) { hash }

    it 'returns hash' do
      expect(subject).to eq hash
    end
  end

  context 'nil' do
    let(:params) { nil }

    it 'returns empty hash' do
      expect(subject).to eq({})
    end
  end

  context 'array' do
    let(:array) { [{ 'title' => 'example glossary' }] }
    let(:params) { array }

    it 'raise error' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
end
