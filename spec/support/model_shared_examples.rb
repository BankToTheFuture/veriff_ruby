# frozen_string_literal: true

RSpec.shared_examples 'model' do
  it 'has Model superclass' do
    expect(described_class.superclass).to eq(::Veriff::Model)
  end
end
