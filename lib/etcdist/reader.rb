require 'etcdist/log'

module Etcdist

  ##
  # Reads config from file system into directories, keys and values.
  class Reader

    ##
    # @param [String] config_dir The path of the config data root directory
    # Returns a hash of type { directory => { key => val } }
    def read(config_dir)
      config_dir = File.expand_path(config_dir)
      files = Dir[ File.join(config_dir, '**', '*') ].reject { |p| File.directory? p }
      Log.info("found #{files.length} config files in #{config_dir}")

      files.inject(Hash.new { |h, k| h[k] = {} }) do |h, f|
        directory = File.dirname(f).gsub(config_dir, '')
        entries = Hash[ IO.readlines(f).map { |e| e.chomp.split('=') } ]
        Log.info("found #{entries.length} entries #{f.gsub(config_dir, '')}")
        Log.debug("entries: #{entries}")
        h[directory].merge!(entries)
        h
      end
    end
  end
end
