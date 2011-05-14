require 'nokogiri'
require 'hashie'
require 'open-uri'

module IVES
  class Venue < Hashie::Mash
    def self.get id
      full_id = "http://ives.info/gb/#{id}" unless id =~ /http:\/\/ives.info\/gb\//
      full_id ||= id
      doc = Nokogiri::XML(open("#{full_id}?format=xml")) do |config|
        config.options = Nokogiri::XML::ParseOptions::NOBLANKS
      end
      attributes = {}
      doc.at("venue").children.each do |node|
        attributes[node.name] = node.children.to_s
      end
      self.new(attributes)
    end
  end
end