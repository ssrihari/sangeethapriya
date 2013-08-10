require 'nokogiri'
require 'httparty'

class SangeethapriyaSearcher
  include HTTParty

  def initialize(url, query)
    @url = url
    @query = query
  end

  def document
    response = HTTParty.post @url, query: { q: @query }
    @document ||= Nokogiri::HTML(response.parsed_response)
  end

  def results
    @results ||= document.css("#searchresults li").inject([]) do |array, result|
      array << {album: result.text, track: result.css("a").text}
    end
  end
end
