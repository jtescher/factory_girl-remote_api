# FactoryGirl::RemoteApi

Simply creates an HTTP API for your FactoryGirl factories to be used by client tests.

Tested against ruby-head, ruby 2.0.0, ruby 1.9.3,  jruby-19mode, jruby-head, and rbx-19mode

[![Build Status](https://travis-ci.org/jtescher/factory_girl-remote_api.png?branch=master)]
(https://travis-ci.org/jtescher/factory_girl-remote_api)
[![Code Climate](https://codeclimate.com/github/jtescher/factory_girl-remote_api.png)]
(https://codeclimate.com/github/jtescher/factory_girl-remote_api)
[![Dependency Status](https://gemnasium.com/jtescher/factory_girl-remote_api.png)]
(https://gemnasium.com/jtescher/factory_girl-remote_api)
[![Coverage Status](https://coveralls.io/repos/jtescher/factory_girl-remote_api/badge.png)]
(https://coveralls.io/r/jtescher/factory_girl-remote_api)
[![Gem Version](https://badge.fury.io/rb/factory_girl-remote_api.png)
](http://badge.fury.io/rb/factory_girl-remote_api)


##Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_girl-remote_api', '~> 0.2.1'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install factory_girl-remote_api
```

Then mount as an engine in your config/routes.rb file.
```ruby
Rails.application.routes.draw do
  ...
  mount FactoryGirl::RemoteApi::Engine => '/factories' if Rails.env.test?
  ...
end
```


## Usage

First install [FactoryGirl](https://github.com/thoughtbot/factory_girl) and create some
[factories](https://github.com/thoughtbot/factory_girl/wiki/Usage).

To use with a client application, start rails in the `test` environment
(or whichever environment has the engine mounted).
```bash
$ rails server -e test
```

Then any FactoryGirl factories you have defined will be available at `/mount_path/:factory_name`

### Example

A user factory in spec/factories/users.rb:
```ruby
FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
  end
end
```

And FactoryGirl::RemoteApi mounted at /factories:
```ruby
Rails.application.routes.draw do
  mount FactoryGirl::RemoteApi::Engine => '/factories' if Rails.env.test?
end
```

Will make the created user available via any client:
```bash
$ curl http://localhost:3000/factories/user?user[first_name]=John&user[last_name]=Doe
{
  "created_at": "2013-06-07T23:02:32Z",
  "first_name": "John",
  "id": 1,
  "last_name": "Doe",
  "updated_at": "2013-06-07T23:02:32Z"
}
```

And attributes for the user without creating it:
```bash
$ curl http://localhost:3000/factories/attributes_for/user?user[first_name]=John
{
  "first_name": "John",
  "last_name": "FactoryDefaultLastName",
}
```

## Usage (As Client)

FactoryGirl::RemoteApi can also be used between rails servers by the client rails app.
First install the gem (You don't have to mount the engine in routes.rb)

Then configure the server URL (if different than localhost:3000/factories) in
`spec/support/factory_girl-remote_api.rb`

```ruby
FactoryGirl::RemoteApi.configure do |config|
  config.server_url = 'http://localhost:3001'  # Default: http://localhost:3000
  config.server_mount_path = '/remote_models'  # Default: /factories
end
```

Then you can create records on the server rails app during tests by includeing the following in your test files:

```ruby
it 'Does something with a model that is persisted on the server' do
   user = FactoryGirl::RemoteApi.create(:user)
   user.id #=> 1
   user.first_name #=> "Tom"
   user.last_name #=> "Smith"
   ...
end
```

And you can build records on the client rails app during tests by includeing the following in your test files:

```ruby
it 'Does something with a model that is persisted on the server' do
   user = FactoryGirl::RemoteApi.build(:user)
   user.id #=> nil
   user.first_name #=> "Tom"
   user.last_name #=> "Smith"
   ...
end
```

And you can get attributes for models defined in factories on the server as well:

```ruby
it 'Does something with attributes of a model that are not persisted on the server' do
   user_attributes = FactoryGirl::RemoteApi.attributes_for(:user, first_name: 'John')
   user_attributes[:id] #=> nil
   user_attributes[:first_name] #=> "John"
   user_attributes[:last_name] #=> "Smith"
   ...
end
```

It is also possible to create or get attributes of a child factory:

 ```ruby
 it 'Does something with attributes of a child factory' do
    user_attributes = FactoryGirl::RemoteApi.attributes_for(:expired_user, parent_factory: 'user')
    user_attributes[:id] #=> nil
    user_attributes[:first_name] #=> "John"
    user_attributes[:last_name] #=> "Smith"
    ...
 end
 ```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
