module HandlebarsPrecompiler
  class Command
    def initialize(template_root, output_file_path)
      @template_root    = template_root
      @output_file_path = output_file_path
    end

    def call
      Rails.logger.info "Running Handlebars::Precompiler with #{command_text}"
      system command_text
    end

  private

    def command_text
      "handlebars #{@template_root} --min --output #{@output_file_path}"
    end
  end
end
