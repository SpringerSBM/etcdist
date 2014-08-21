# Etcdig

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'etcdig'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install etcdig

## Usage

Create a directory structure that matches your desired etcd keyspace hierarchy:

    +- conf
      +- foo
        +- bar
          -- app.properties

In app.properties, define keys and values:

    fish=plankton
    cows=grass

Then, pass the path to the directory to the Etcdig `run` method:

```ruby
Etcdig.run(:config_dir => '/path/to/conf')
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/etcdig/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
