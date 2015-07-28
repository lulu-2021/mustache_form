#
module MustacheForm
  class Railtie < Rails::Railtie
    #
    # enable namespaced configuration in Rails environments
    config.mustache_form = ActiveSupport::OrderedOptions.new
    #
    initializer :after_initialize do |app|
      #
      MustacheForm.configure do |config|
        config.simple_form_enabled = app.config.mustache_form[:simple_form_enabled]
      end
      #
      # dynamically load the client rails app module that has the stuff
      #LoadLists.load
    end
  end
end
#
