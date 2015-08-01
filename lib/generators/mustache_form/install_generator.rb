module MustacheForm
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy MustacheForm initializer"
      source_root File.expand_path('../templates', __FILE__)

      def copy_config
        template "config/initializers/mustache_form.rb"
      end
    end
  end
end
