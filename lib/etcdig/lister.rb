# Encoding: utf-8

module Etcdig
  class Lister

    ##
    # Returns a hash of type { directory => { key => val } }
    def list(config_dir)
      config_dir = File.expand_path(config_dir)
      puts "looking for properties files in: #{config_dir}"

      files = Dir["#{config_dir}/**/app.properties"]
      puts "found #{files.length} properties files"

      Hash[files.map do |f|
        directory = File.dirname(f).gsub(config_dir, '')
        entries = IO.readlines(f).map { |e| e.chomp.split('=') }
        puts "found #{entries.length} entries for #{directory}"
        [directory, Hash[entries]]
      end]
    end

  end
end
