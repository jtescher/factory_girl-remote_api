# FactoryGirlRails::RemoteApi

Simply creates an HTTP API for your FactoryGirl factories to be used by client tests.

Tested against ruby-head, ruby 2.0.0, ruby 1.9.3,  jruby-19mode, jruby-head, and rbx-19mode

[![Build Status](https://travis-ci.org/jtescher/factory_girl_rails-remote_api.png?branch=master)]
(https://travis-ci.org/jtescher/factory_girl_rails-remote_api)
[![Code Climate](https://codeclimate.com/github/jtescher/factory_girl_rails-remote_api.png)]
(https://codeclimate.com/github/jtescher/factory_girl_rails-remote_api)
[![Dependency Status](https://gemnasium.com/jtescher/factory_girl_rails-remote_api.png)]
(https://gemnasium.com/jtescher/factory_girl_rails-remote_api)


##Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_girl_rails-remote_api', '~> 0.0.1'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install factory_girl_rails-remote_api
```

Then mount as an engine in your config/routes.rb file.
```ruby
Rails.application.routes.draw do
  ...
  mount FactoryGirlRails::RemoteApi::Engine => '/factories' if Rails.env.test?
  ...
end
```


## Usage

First install [FactoryGirl](https://github.com/thoughtbot/factory_girl_rails) and create some
[factories](https://github.com/thoughtbot/factory_girl/wiki/Usage).

To use with a client application, start rails in the `test` environment (or whichever environment has the engine mounted).
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

And FactoryGirlRails::RemoteApi mounted at /factories:
```ruby
Rails.application.routes.draw do
  mount FactoryGirlRails::RemoteApi::Engine => '/factories' if Rails.env.test?
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


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
