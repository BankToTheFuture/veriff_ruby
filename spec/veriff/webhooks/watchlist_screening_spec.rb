# frozen_string_literal: true

RSpec.describe Veriff::Webhooks::WatchlistScreening do
  describe 'initialization' do
    subject(:model) { described_class.new(params) }

    context 'with valid params' do
      let(:params) { { "attempt_id": 1, "foo": "bar" }.to_json }

      it 'can be initialized without id' do
        expect { model }.not_to raise_error
      end
    end

    context 'with invalid params' do
      let(:params) { { "id": 1, "foo": "bar" }.to_json }

      it 'cannot be initialized without attempt_id' do
        expect { model }.to raise_error(KeyError, 'key not found: :attempt_id')
      end
    end
  end

  describe '#parse' do
    subject(:parse) { described_class.parse(body, signature) }

    let(:signature) { SecureRandom.uuid }
    let(:body) do
      {
        "checkType": "updated_result",
        "attemptId": "54233318-f81c-4ec4-8e4c-413168a3f5e6",
        "vendorData": "12345678",
        "matchStatus": "possible_match",
        "searchTerm": {
          "name": "Mirko Kokki",
          "year": "1960"
        },
        "totalHits": 5,
        "createdAt": "2021-06-02T11:04:00.287Z",
        "hits": [
          {
            "matchedName": "Miro kokkino",
            "countries": [
              "Australia",
              "Brazil"
            ],
            "dateOfBirth": "1963",
            "dateOfDeath": nil,
            "matchTypes": [
              "name_fuzzy"
            ],
            "aka": [
              "Mirkoni kokki",
              "Mirkor Kokki"
            ],
            "associates": [
              "Desmon Lamela",
              "Fred Austin"
            ],
            "listingsRelatedToMatch": {
              "warnings": [
                {
                  "sourceName": "FBI Most Wanted",
                  "sourceUrl": "http://www.fbi.gov/wanted",
                  "date": nil
                }
              ],
              "sanctions": [
                {
                  "sourceName": "Argentina Ministerio de Relaciones Exteriores y Culto Sanciones de la ONU",
                  "sourceUrl": "https://www.cancilleria.gob.ar/es/politica-exterior/seguridad-internacional/comite-de-sanciones",
                  "date": nil
                },
                {
                  "sourceName": "Argentina Public Registry of People and Entities linked to acts of Terrorism and Terrorism Financing",
                  "sourceUrl": "https://repet.jus.gob.ar/#entidades",
                  "date": nil
                }
              ],
              "fitnessProbity": [
                {
                  "source_name": "United Kingdom Insolvency Service Disqualified Directors",
                  "source_url": "https://www.insolvencydirect.bis.gov.uk/IESdatabase/viewdirectorsummary-new.asp"
                }
              ],
              "pep": [
                {
                  "source_name": "United States Navy Leadership and Senior Military Officials",
                  "source_url": "https://www.navy.mil/Leadership/Biographies/"
                }
              ],
              "adverseMedia": [
                {
                  "date": "2020-09-23T00:00:00Z",
                  "source_name": "SNA's Old Salt Award Passed to Adm. Davidson",
                  "source_url": "https://www.marinelink.com/amp/news/snas-old-salt-award-passed-adm-davidson-443093"
                }
              ]
            }
          }
        ]
      }.to_json
    end

    before do
      allow(Veriff).to receive(:validate_signature).with(body, signature).and_return(true)
    end

    it 'returns attempt id' do
      expect(parse.attempt_id).to eq("54233318-f81c-4ec4-8e4c-413168a3f5e6")
    end

    it 'returns created at' do
      expect(parse.created_at).to eq("2021-06-02T11:04:00.287Z")
    end
  end
end
