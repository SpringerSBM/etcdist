# Etcdist

This is a small gem that helps you manage your etcd keys and values in a way that's easy to version control.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'etcdist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install etcdist

## Usage

### Create the config data

Create your desired directory structure. This will be replicated in etcd. For example:

```bash
mkdir -p config/foo/bar
```
    
Then create a file in the leaf directory containing the keys and values that you want to go into etcd. For example:    

```bash    
cat <<EOT > config/foo/bar/food.config
fish=plankton
cows=grass
EOT
```    

The name of the file containing the keys and values doesn't matter. In fact, you can split the configuration into multiple files, if you want. An example would look like:

```text
./config
└── ./foo
    └── ./bar
        ├── food.config    # contains fish=plankton and cows=grass
        └── more.config    # could contain more keys and values
```
            
### Populate etcd

Then pass the path to your config data directory to Etcdist. For example:

```ruby
#!/usr/bin/env ruby
require 'etcdist'
config_dir = '.../config'
Etcdist.execute(config_dir)
```

### Configuration

#### Etcd host

```ruby
Etcdist.execute(config_dir) # defaults to localhost:4001
Etcdist.execute(config_dir, host: '127.0.0.1', port: 4003)
```

#### Log level

You can control the log level, as follows:

```ruby
Etcdist::Log.level = :info
```

## Developing

Clone the source code. To see what's possible, run:

    $ rake -T
    
To continuously run tests, run:

    $ guard

## Contributing

1. Fork it ( https://github.com/[my-github-username]/etcdist/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
