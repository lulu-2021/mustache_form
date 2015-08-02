#
module MustacheForm
  class Railtie < Rails::Railtie

    config.after_initialize do
      unless MustacheForm.configured?
        warn 'Mustache Form is not configured in the application and will use the default values.' +
          ' Use `rails generate mustache_form:install` to generate the Mustache Form configuration.'
      end
    end
  end
end
#
