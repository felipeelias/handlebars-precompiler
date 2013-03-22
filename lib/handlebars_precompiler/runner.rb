module HandlebarsPrecompiler
  class Runner
    attr_accessor :config, :command

    def initialize(config = nil)
      @config      = config
      @last_files  = []
      @last_update = Time.at(0).to_i
    end

    def updated?
      return true unless output_file_exists?

      new_files  = list_files
      new_update = last_update_time list_files

      if new_update != @last_update || file_list_changed?(list_files)
        @last_files  = new_files
        @last_update = new_update
        true
      else
        false
      end
    end

    def run
      command.call if updated?
    end

    def command
      @command ||= Command.new(config.template_root, config.output_file)
    end

  private

    def output_file_exists?
      File.exists? config.output_file
    end

    def list_files
      Dir["#{config.template_root}/**/*.#{config.extension}"]
    end

    def file_list_changed?(new_files)
      @last_files.size != new_files.size
    end

    def last_update_time(files)
      files.map { |path| File.mtime(path).to_i }.max
    end
  end
end
