# Allegro::Webapi

Allegro api wrapper written in ruby. Basic functions supported.

**Support**
- Searching
- Connecting with allegro client via soap (with Savon gem)
- fetching profile data

## Installation

Add this line to your application's Gemfile:

    gem 'allegro-webapi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install allegro-webapi

## Usage

_Connecting to client_

	 client = Allegro::WebApi::Client.new do |config|
      config.user_login = 'User'
      config.password = 'secret'
      config.webapi_key = '1234'
      config.country_code = 1
      config.local_version = 1234
    end
 	
    client.login
    
_User data_

	user = Allegro::WebApi::User.new(client)
    user.do_get_my_data

Calls on user: birth_date, phone, first_name, rating, company, city, address, email, id

_Search_

	search = Allegro::WebApi::Search.new(client)
    
    search.search_query(search_string, options)#reference allegro api


 
    
    
 



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
