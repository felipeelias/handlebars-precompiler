module HandlebarsPrecompiler
  class Config
    attr_writer :template_root

    def template_root
      if defined? Rails
        @template_root ||= Rails.root.join('app/assets/javascripts/templates')
      else
        @template_root
      end
    end

    attr_writer :output_file

    def output_file
      if defined? Rails
        @output_file ||= Rails.root.join('app/assets/javascripts/templates.js')
      else
        @output_file
      end
    end

    attr_writer :extension

    def extension
      @extension ||= :handlebars
    end
  end
end
