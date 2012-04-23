require_relative 'reloader'
require_relative 'precompiler'

module Handlebars
  module Precompiler
    class Railtie < Rails::Railtie
      def self.reloader
        @reloader ||= Handlebars::Precompiler::Reloader.new
      end

      initializer "handlebars.callbacks" do |app|
        app.reloaders << Handlebars::Precompiler::Railtie.reloader
        ActionDispatch::Reloader.to_prepare do
          Handlebars::Precompiler::Railtie.reloader.execute_if_updated
        end
      end
    end
  end
end
