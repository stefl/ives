International Venue and Event Standard
======================================

"The IVES (International Venue and Event Standard) Project is an independent, non-profit partnership dedicated to the development and promotion of a standard suite of XML specifications and Venue identification tools, designed to ease the automation and exchange of event and venue data."

Translation - every cultural venue in the UK (and hopefully the World) will have a unique identifier that you can use in your project.

This is an unofficial gem to consume the XML API offered by the service.

Usage
-----

    gem install ives
    
or with Bundler add this to your Gemfile

    gem "ives"

What does it do?
----------------

It currently provides a small subset of the API methods:

    require 'ives'
    kelvin_hall = IVES::Venue.get("r34lt")
    => <#IVES::Venue address="1445 Argyle Street" alt_names="" country_code="GB" latitude="55.8685" longitude="-4.29354" postal_code="G3 8AW" previous_names="" radius="" region="" town="Glasgow" venue_name="Kelvin Hall International Sports Arena" vid_type="distinct">
    kelvin_hall.latitude
    => "55.8685"
    irb(main):004:0> require 'pp'
    => true
    irb(main):005:0> pp kelvin_hall.to_hash
    {"radius"=>"",
     "region"=>"",
     "address"=>"1445 Argyle Street",
     "latitude"=>"55.8685",
     "country_code"=>"GB",
     "postal_code"=>"G3 8AW",
     "previous_names"=>"",
     "venue_name"=>"Kelvin Hall International Sports Arena",
     "alt_names"=>"",
     "vid_type"=>"distinct",
     "longitude"=>"-4.29354",
     "town"=>"Glasgow"}
    => nil

Other methods
-------------

    IVES::Venue.find(free_text)
    
This will search for a matching named venue. This is probably the 90% use case. "What is the name of the theatre you want?", etc.

    IVES::Venue.find_by_postcode(postcode)
    
This will search against a venue postcode. No way of knowing if it strips spaces or not at the moment.

More methods to come as and when required.

Contributing to ives
====================
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
=========

Copyright (c) 2011 Stef Lewandowski. See LICENSE.txt for further details.

