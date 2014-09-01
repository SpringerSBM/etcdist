require 'etcdist/log'

module Etcdist
  # Reads data from file system into directories, keys and values.
  class Reader
    # @param [String] dir The path to the data directory
    def initialize(dir)
      @dir = dir
    end

    # Returns a hash of type { directory => { key => val } }
    def read
      @dir = File.expand_path(@dir)
      files = Dir[File.join(@dir, '**', '*')].reject { |p| File.directory? p }
      Log.info("found #{files.length} files in #{@dir}")

      files.reduce(Hash.new { |h, k| h[k] = {} }) do |h, f|
        directory = File.dirname(f).gsub(@dir, '')
        entries = Hash[IO.readlines(f).map { |e| e.chomp.split('=') }]
        Log.debug("found #{entries.length} entries in #{f.gsub(@dir, '')}: #{entries}")
        h[directory].merge!(entries)
        h
      end
    end
  end
end
