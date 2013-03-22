module HandlebarsPrecompiler
  class Middleware
    attr_accessor :runner

    def initialize(app, runner, config)
      @app    = app
      @runner = runner

      runner.config = config
    end

    def call(env)
      runner.run
      @app.call(env)
    end
  end
end
