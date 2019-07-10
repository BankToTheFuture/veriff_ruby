# frozen_string_literal: true

module Veriff
  module MediaHolder
    def images
      fetch_media
      @images
    end

    def videos
      fetch_media
      @videos
    end

    def media
      images | videos
    end

    private

    def fetch_media
      return unless @images.nil?

      response = Veriff.get(
        "/#{self.class.api_collection_name}/#{id}/media",
        signature: id
      ).parsed_response

      @images = response[:images].map { |image| Media.new(image) }
      @videos = response[:videos].map { |video| Media.new(video) }
    end
  end
end
