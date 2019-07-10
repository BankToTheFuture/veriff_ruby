# frozen_string_literal: true

RSpec.describe Veriff::Decision do
  subject(:person) { described_class.new(params) }

  let(:params) { { id: 123 } }
  it_behaves_like 'model'
end
