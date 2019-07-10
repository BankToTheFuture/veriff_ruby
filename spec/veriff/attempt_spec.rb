# frozen_string_literal: true

RSpec.describe Veriff::Attempt do
  subject(:person) { described_class.new(params) }

  let(:params) { { id: 123 } }
  it_behaves_like 'model'
  it_behaves_like 'media_holder'
end
