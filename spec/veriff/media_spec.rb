# frozen_string_literal: true

RSpec.describe Veriff::Media do
  it_behaves_like 'model'

  subject(:model) { described_class.new(params) }

  let(:params) do
    {
      id: 1,
      name: 'image_name',
      url: 'http://download',
      timestamp: {
        url: 'http://timestamp',
        id: 2
      },
      size: 432_112,
      mimetype: 'image/png'
    }
  end

  it 'has timestamp accessor' do
    expect(model.timestamp).to be_a(::Veriff::Timestamp)
  end
end
