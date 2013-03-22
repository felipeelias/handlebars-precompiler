require 'handlebars_precompiler/version'
require 'handlebars_precompiler/config'
require 'handlebars_precompiler/middleware'
require 'handlebars_precompiler/command'
require 'handlebars_precompiler/runner'
require 'handlebars_precompiler/engine' if defined? Rails

module HandlebarsPrecompiler
  def self.config
    @config ||= Config.new
  end

  def self.configure(&block)
    block.call(self.config)
  end
end
