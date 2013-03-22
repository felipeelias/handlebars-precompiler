module HandlebarsPrecompiler
  class Engine < ::Rails::Engine
    initializer 'handlebars_precompiler.middleware' do |app|
      app.middleware.use Middleware, Runner.new, ::HandlebarsPrecompiler.config
    end
  end
end
