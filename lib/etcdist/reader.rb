require 'etcdist/log'

module Etcdist

  ##
  # Reads config from file system into directories, keys and values.
  class Reader

    ##
    # Returns a hash of type { directory => { key => val } }
    def read(config_dir)
      config_dir = File.expand_path(config_dir)
      Log.info("looking for config files in: #{config_dir}")

      files = Dir["#{config_dir}/**/app.properties"]
      Log.info("found #{files.length} config files")

      Hash[files.map do |f|
        directory = File.dirname(f).gsub(config_dir, '')
        entries = IO.readlines(f).map { |e| e.chomp.split('=') }
        Log.info("found #{entries.length} entries for #{directory}")
        [directory, Hash[entries]]
      end]
    end

  end
end
