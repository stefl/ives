require 'nokogiri'
require 'hashie'
require 'open-uri'
require 'httpi'

module IVES
  class Venue < Hashie::Mash
    def self.get id
      full_id = id.to_s
      unless id.to_s =~ /ives\.info/
        full_id = "http://ives.info/gb/#{id}" 
      end      
      doc = Nokogiri::XML(open("#{full_id}?format=xml")) do |config|
        config.options = Nokogiri::XML::ParseOptions::NOBLANKS
      end
      attributes = {}
      doc.at("venue").children.each do |node|
        attributes[node.name.to_s] = node.children.to_s
      end
      attributes["id"] = id
      self.new(attributes)
    end
    
    #venue_name	Name of venue
    #address	Address of venue (will be matched against both address fields)
    #town	Town
    #postal_code	Postcode/Zipcode
    def self.find terms={}
      request = HTTPI::Request.new
      request.url = "http://www.ives.info/search"
      request.body = terms.collect{|k,v| "#{k}=#{v}"}.join("&")
      result = HTTPI.post request
      doc = Nokogiri::HTML(result.body)
      top = doc.css("ul.searchResults li a").first.attributes["href"].to_s rescue nil
      puts top.inspect
      if top
        Venue.get(top)
      else
        nil
      end
    end
    
    def self.search name
      find(:venue_name=>name)
    end
    
    def self.find_by_postcode postcode
      find(:postal_code=>postcode)
    end
  end
end