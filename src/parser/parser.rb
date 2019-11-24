require 'nokogiri'
require 'net/http'

class Parser
  attr_accessor :response, :doc

  def fetch url
    @response = Net::HTTP.get(URI.parse(url))
    charset = 'utf-8'
    @doc = Nokogiri::HTML.parse(@response, nil, charset)
    @doc.search('br').each { |n| n.replace("\n") }
  end

end