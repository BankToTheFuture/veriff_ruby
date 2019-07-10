# frozen_string_literal: true

RSpec.shared_examples 'related_resource' do |klass, data_key|
  resource_name = klass.to_s.split('::').last.downcase.to_sym
  data_key ||= resource_name

  let(:self_name) { "#{described_class.to_s.split('::').last.downcase}s" }

  describe "##{resource_name}" do
    before do
      allow(Veriff)
        .to receive(:get)
        .with("/#{self_name}/123/#{resource_name}", signature: 123)
        .and_return(response_mock)
    end

    let(:response_mock) do
      instance_double(HTTParty::Response, parsed_response: parsed_response)
    end

    let(:parsed_response) { { data_key => { id: 1 } } }

    it "calls get #{resource_name}" do
      session.public_send(resource_name)
      expect(Veriff)
        .to have_received(:get)
        .with("/#{self_name}/123/#{resource_name}", signature: 123)
        .once
    end

    it 'creates new klass object with returned person details' do
      allow(klass).to receive(:new)
      session.public_send(resource_name)
      expect(klass).to have_received(:new).with(parsed_response[data_key]).once
    end

    it 'returns new klass object' do
      expect(session.public_send(resource_name)).to be_a(klass)
    end

    it 'does not create new object in consecutive call' do
      expect(session.public_send(resource_name)).to be_equal(session.public_send(resource_name))
    end
  end
end

RSpec.shared_examples 'related_resources' do |klass, data_key|
  resource_name = "#{klass.to_s.split('::').last.downcase}s".to_sym
  data_key ||= resource_name

  let(:self_name) { "#{described_class.to_s.split('::').last.downcase}s" }

  describe "##{resource_name}" do
    before do
      allow(Veriff)
        .to receive(:get)
        .with("/#{self_name}/123/#{resource_name}", signature: 123)
        .and_return(response_mock)
    end

    let(:response_mock) do
      instance_double(HTTParty::Response, parsed_response: parsed_response)
    end

    let(:parsed_response) { { data_key => [{ id: 1 }, { id: 2 }, { id: 3 }] } }

    it "calls get #{resource_name}" do
      session.public_send(resource_name)
      expect(Veriff)
        .to have_received(:get)
        .with("/#{self_name}/123/#{resource_name}", signature: 123)
        .once
    end

    it 'creates new klass object with returned person details' do
      allow(klass).to receive(:new)
      session.public_send(resource_name)
      parsed_response[data_key].each do |item|
        expect(klass).to have_received(:new).with(item).once
      end
    end

    it 'returns new array of klass objects' do
      expect(session.public_send(resource_name)).to all(be_a(klass))
    end

    it 'does not create new object in consecutive call' do
      expect(session.public_send(resource_name)).to be_equal(session.public_send(resource_name))
    end
  end
end
