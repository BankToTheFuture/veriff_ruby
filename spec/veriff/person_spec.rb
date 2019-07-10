# frozen_string_literal: true

RSpec.describe Veriff::Person do
  subject(:person) { described_class.new(params) }

  let(:params) do
    { id: 1 }
  end
  it_behaves_like 'model'
end
