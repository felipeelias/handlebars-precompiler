module Handlebars
  module Precompiler
    class Reloader
      attr_reader :paths, :reloader

      def initialize
        @paths    = Precompiler.files_to_watch
        @reloader = ActiveSupport::FileUpdateChecker.new(@paths, &self.method(:precompile!))
      end

      def execute_if_updated
        update_paths_for_new_files!
        reloader.execute_if_updated
      end

      private

      def precompile!
        Precompiler.run!
      end

      def files_changed?
        @paths != Precompiler.files_to_watch
      end

      # unfortunately FileUpdateChecker does not check for new or removed files
      # so this method resets paths and forces the execution
      def update_paths_for_new_files!
        if files_changed?
          @paths = Precompiler.files_to_watch
          reloader.instance_variable_set :@paths, @paths
        end
      end
    end
  end
end
