require 'etcdist/log'
require 'pathname'

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
        entries = Hash[read_non_blank_lines(f).map { |e| e.chomp.split('=', 2) }.select { |k, _| valid_key?(k) }]
        Log.debug("found #{entries.length} entries in #{f.gsub(@dir, '')}: #{entries}")
        h[directory].merge!(entries)
        h
      end
    end

    def all_dirs
      @dir = Pathname.new File.expand_path(@dir)
      root = Pathname.new '/'

      descendant_dirs = Dir[File.join(@dir, '**', '*')].select { |p| File.directory? p }
      relative_descendant_dirs = descendant_dirs.map { |d| Pathname.new(d).relative_path_from @dir }
      dirs = relative_descendant_dirs.map { |d| root.join(d).to_s }

      dirs.push '/'
    end

    private

    def read_non_blank_lines(f)
      lines = IO.readlines(f)
      lines.delete_if { |line| line !~ /\S/ }
      lines
    end

    def valid_key?(key)
      is_valid = !(key.include? '/')
      Log.warn("ignoring invalid key #{key}") unless is_valid
      is_valid
    end
  end
end
