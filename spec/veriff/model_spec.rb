# frozen_string_literal: true

RSpec.describe Veriff::Model do
  subject(:model) { described_class.new(id: 1, foo: :bar) }

  it 'cannot be initialized without id' do
    expect { described_class.new({}) }
      .to raise_error(KeyError, 'key not found: :id')
  end

  it 'responds with initialized keys' do
    expect(model.foo).to eq(:bar)
  end

  it 'raises error when sending not existing key' do
    expect { model.baz }.to raise_error(NoMethodError, /undefined method `baz'/)
  end
end
