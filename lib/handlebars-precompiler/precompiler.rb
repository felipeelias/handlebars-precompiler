module Handlebars
  module Precompiler
    def self.template_root
      Rails.root.join('app/assets/javascripts/templates')
    end

    def self.files_to_watch
      Dir.glob template_root.join('**/*.handlebars')
    end

    def self.command
      output    = template_root.join 'templates.js'
      arguments = "#{template_root} --min --output #{output}"
      "handlebars #{arguments}"
    end

    def self.run!
      Rails.logger.info "Running Handlebars::Precompiler with #{command}"
      system command
    end
  end
end
