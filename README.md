[![Gem Version](https://badge.fury.io/rb/etcdist.svg)](http://badge.fury.io/rb/etcdist)
[![Build Status](https://travis-ci.org/SpringerSBM/etcdist.svg?branch=master)](https://travis-ci.org/SpringerSBM/etcdist)

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

### Create the data

Create your desired directory structure. This will be replicated in etcd. For example:

```bash
$ mkdir -p data/foo/bar
```

Then create a file in the leaf directory containing the keys and values that you want to go into etcd. For example:

```bash
$ cat <<EOT > data/foo/bar/food.data
fish=plankton
cows=grass
EOT
```

The name of the file containing the keys and values doesn't matter. In fact, you can split the data into multiple files, if you want. An example would look like:

```text
./data
└── ./foo
    └── ./bar
        ├── food.data    # contains fish=plankton and cows=grass
        └── more.data    # could contain more keys and values
```

### Populate etcd

Then pass the path to your data directory to Etcdist. For example:

```ruby
#!/usr/bin/env ruby
require 'etcdist'
Etcdist.execute('data')
```

If you want Etcdist to remove data from etcd that is no longer in your data files, use `dangerous` mode:

```ruby
Etcdist.execute('data', dangerous: true)
```

If you just want to perform a trial run without making any changes, then use the `dry_run` mode:

```ruby
Etcdist.execute('data', dangerous: true, dry_run: true)
```

## Configuration

### Etcd host

```ruby
Etcdist.execute(dir) # defaults to localhost:4001
Etcdist.execute(dir, host: '127.0.0.1', port: 4003)
```

### Log level

You can control the log level, as follows:

```ruby
Etcdist::Log.level = :info
```

## Developing

Clone the source code. To see what's possible, run:

    $ rake -T

To get the acceptance test to pass, make sure you've got etcd running locally:

    $ docker run -d -p 4001:4001 coreos/etcd

To continuously run tests, run:

    $ guard

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
