# frozen_string_literal: true

require('timecop')

module Veriff
  RSpec.describe Session do
    subject(:session) { described_class.new(params) }

    let(:params) { { id: 123 } }
    describe '#create' do
      before do
        allow(Veriff)
          .to receive(:post)
          .with('/sessions', body: instance_of(String)).and_return(response_mock)
      end

      let(:response_mock) do
        instance_double(HTTParty::Response, parsed_response: parsed_response)
      end

      let(:parsed_response) { { verification: { id: 1, url: 'https://magic' } } }

      it 'calls session create with default arguments' do
        Timecop.freeze('2019-07-10T10:32:00.402Z') do
          described_class.create
          expect(Veriff)
            .to have_received(:post)
            .with('/sessions', body: '{"verification":{"features":["selfid"],"timestamp":"2019-07-10T10:32:00.402Z"}}')
            .once
        end
      end

      it 'calls session create with passed arguments' do
        described_class.create(timestamp: '2017-07-10T10:32:00.402Z', lang: :pl)
        expect(Veriff)
          .to have_received(:post)
          .with('/sessions', body: '{"verification":{"timestamp":"2017-07-10T10:32:00.402Z","lang":"pl","features":["selfid"]}}')
          .once
      end

      it 'creates new Session object with returned verification details' do
        allow(described_class).to receive(:new)
        described_class.create
        expect(described_class).to have_received(:new).with(parsed_response[:verification]).once
      end

      it 'returns new Session object' do
        expect(described_class.create).to be_a(described_class)
      end
    end

    it_behaves_like 'model'
    it_behaves_like 'media_holder'
    it_behaves_like 'related_resource', Person
    it_behaves_like 'related_resource', Decision, :verification
    it_behaves_like 'related_resources', Attempt, :verifications
    it_behaves_like 'related_resources', Timestamp
  end
end
