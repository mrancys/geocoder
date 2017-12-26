## Enviroment
#### Assumptions

I could have used DotEnv for configuration, HTTParty for connections, but decided to keep minimal footprint and keep it simple.

* Ruby 2.4.2 -> ~/.ruby-version
* Bundler 1.16.0
* Rack 2.0.3
* Sinatra

Ruby standard library:

* Net::HTTP - connection to APIs
* JSON - parser
* MiniTest - testing

### Setup

1. Set API configuration
`cp config/application.rb.example config/application.rb`

Set GOOGLE_GEOCODING_API to Google Account current one.

`vim config/application.rb`

2. Install gems `bundle install`
3. Run tests `ruby test/*/*`
3. Run application `rackup config.ru`
4. Query

`curl localhost:9292/address/Berlin`

`curl localhost:9292/address/1600/Amphitheatre/Parkway/Mountain/View/CA`

### Guideline Questions

* How do you handle configuration values? What if those values change?
> Values are in separate file `config/application.rb`, you're welcome to change.

* What happens if we encounter an error with the third-party API integration?
> We get error code or message whichever is present f.e. `{"error":"ZERO_RESULTS"}%`

* Will it also break our application, or are they handled accordingly?
> No it shouldn't break our application.

Please only include this whenever you have additional time to do so. Our BIGBOSS
said that we will need to change the third-party geocoder API to another one.

* How can we change our current solution so that we can make this change as seamless as possible?

> Define generic Connection manager class as interface which interacts with NetHTTP library and client as implementation details for a specific client as Bing Maps, OpenStreet or another third party library.

* Or how will we change (or refactor) our solution so that any future changes with the third-party integration is only done in isolation?

> Define GET, POST, PATCH, PUT, DELETE as generic methods in generic ConnectionManager and create new Client class inheriting that class.
