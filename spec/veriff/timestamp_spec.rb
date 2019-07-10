# frozen_string_literal: true

RSpec.describe Veriff::Timestamp do
  it_behaves_like 'model'

  subject(:model) { described_class.new(params) }

  let(:params) do
    { id: 1,
      context: 'timestamp_type',
      signature: '70f1f016a027a1d7a60d6723f66f8135826c08584364497f4cbaf5362139ca21',
      data_hash: {
        algorithm: 'SHA-256',
        value: 'some_value'
      } }
  end

  it 'has algorithm accessor' do
    expect(model.algorithm).to eq('SHA-256')
  end

  it 'has value accessor' do
    expect(model.value).to eq('some_value')
  end
end
