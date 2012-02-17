require_relative 'reloader'
require_relative 'precompiler'

module Handlebars
  class Railtie < Rails::Railtie
    def self.reloader
      @reloader ||= Handlebars::Reloader.new
    end

    initializer "handlebars.callbacks" do
      ActionDispatch::Reloader.to_prepare do
        Handlebars::Railtie.reloader.execute_if_updated
      end
    end
  end
end
