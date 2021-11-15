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

    describe '#watchlist_screening' do
      let(:parsed_response) do
        {
          status: 'success',
          data: {
            attempt_id: "aea9ba6d-1b47-47fc-a4fc-f72b6d3584a7",
            vendor_data: nil,
            check_type: "updated_result",
            match_status: "possible_match",
            search_term: {
              name: "Mirko Kokki",
              year: "1960"
            },
            total_hits: 1,
            created_at: "2021-07-05T13:23:59.851Z",
            hits: [{
              matched_name: "Miro kokkino",
              countries: [
                "Australia",
                "Brazil"
              ],
              date_of_birth: "1963",
              date_of_death: nil,
              match_types: [
                "aka_exact",
                "year_of_birth"
              ],
              aka: [
                "Mirkoni kokki",
                "Mirkor Kokki"
              ],
              associates: [
                "Desmon Lamela",
                "Fred Austin"
              ],
              listings_related_to_match: {
                warnings: [{
                  source_name: "FBI Most Wanted",
                  source_url: "http://www.fbi.gov/wanted",
                  date: nil
                }],
                sanctions: [{
                  source_name: "Argentina Ministerio de Relaciones Exteriores y Culto Sanciones de la ONU",
                  source_url: "https://www.cancilleria.gob.ar/es/politica-exterior/seguridad-internacional/comite-de-sanciones",
                  date: nil
                }],
                fitness_probity: [],
                pep: [{
                  source_name: "United Kingdom Insolvency Service Disqualified Directors",
                  source_url: "https://www.insolvencydirect.bis.gov.uk/IESdatabase/viewdirectorsummary-new.asp",
                  date: nil
                }],
                adverse_media: [{
                  source_name: "SNA's Old Salt Award Passed to Adm. Davidson",
                  source_url: "https://www.marinelink.com/amp/news/snas-old-salt-award-passed-adm-davidson-443093",
                  date: nil
                }]
              }
            }]
          }
        }
      end

      before do
        allow(Veriff)
          .to receive(:get)
          .with("/sessions/123/watchlist-screening", signature: 123)
          .and_return(response_mock)
      end

      let(:response_mock) do
        instance_double(HTTParty::Response, parsed_response: parsed_response)
      end

      it "calls get watchlist_screening" do
        session.watchlist_screening

        expect(Veriff)
          .to have_received(:get)
          .with("/sessions/123/watchlist-screening", signature: 123)
          .once
      end

      it 'creates new WatchlistScreening object with returned watchlist screening details' do
        allow(WatchlistScreening).to receive(:new)

        session.watchlist_screening

        expect(WatchlistScreening).to have_received(:new).with(parsed_response[:data]).once
      end

      it 'returns new WatchlistScreening object' do
        expect(session.watchlist_screening).to be_a(WatchlistScreening)
      end

      it 'does not create new object in consecutive call' do
        expect(session.watchlist_screening).to be_equal(session.watchlist_screening)
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
