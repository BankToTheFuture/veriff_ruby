# frozen_string_literal: true

RSpec.shared_examples 'media_holder' do
  describe '#media' do
    before do
      allow(Veriff)
        .to receive(:get)
        .with("/#{described_class.api_collection_name}/123/media", signature: 123)
        .and_return(response_mock)
    end

    let(:response_mock) do
      instance_double(HTTParty::Response, parsed_response: parsed_response)
    end

    let(:parsed_response) do
      { images: [{ id: 1 }, { id: 2 }, { id: 3 }],
        videos: [{ id: 4 }, { id: 5 }, { id: 6 }] }
    end

    it 'calls get media' do
      subject.media
      expect(Veriff)
        .to have_received(:get)
        .with("/#{described_class.api_collection_name}/123/media", signature: 123)
        .once
    end

    it 'creates new ::Veriff::Media object with returned person details' do
      allow(::Veriff::Media).to receive(:new)
      subject.media
      (parsed_response[:images] | parsed_response[:videos]).each do |item|
        expect(::Veriff::Media).to have_received(:new).with(item).once
      end
    end

    it 'returns new array of ::Veriff::Media objects' do
      expect(subject.media).to all(be_a(::Veriff::Media))
    end
  end
end
