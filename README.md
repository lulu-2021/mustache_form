# MustacheForm

## Builds
[![Build Status](https://travis-ci.org/netflakes/mustache_form.svg?branch=master)](https://travis-ci.org/netflakes/mustache_form)


This is a small library that adds a set of helper methods to Mustache view classes. Mustache allows complete
seperation of concerns with view templates. With Mustache, the typical view layer is split up into two sub-layers: a Ruby Class-based "view" and an HTML "template", so you can concentrate on crafting your HTML without polluting it with embedded Ruby logic. This separation also makes it easier to test your view-code. The helper module has wrapper methods for the basic rails form_tag and form_for helpers. The current version also has wrappers for the simple_form form_helpers as well.

The idea initially was sparked off by a gist from (https://github.com/dbi) - Thanks!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mustache_form'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mustache_form


## Installation - Configuration

Mustache form has an install generator that creates an initializer allowing you to turn on and off
options. For now the only option is to enable the SimpleForm support globally. Basically this means
that when this option is turned on - then the simple_form helper will always be used.

You can safely turn this on if you are using simple_form as you can also turn it off for individual
forms, see below:




## Usage

The best way to explain how to use this little gem is with a few code samples from an existing
project of mine.

Sample template file with a form...

```
{{# labeled_simple_form }}
  {{ alert }}

  <fieldset>
  <div class="input_row">
    <div class="input_field">
      <!--{{ first_name_label }}-->
      {{ first_name_field }}
    </div>

    <div class="input_field">
      {{ last_name_field }}
    </div>

    <div class="input_field">
      {{ email_address_field }}
    </div>

    <div class="input_field">
      {{ mobile_phone_field }}
    </div>

    <div class="input_field">
      {{ home_number_field }}
    </div>
  </div>

  <div class="buttons">
    {{ submit_button }} {{ cancel_button }}
  </div>
</fieldset>

{{/ labeled_simple_form }}
```

Sample view class that goes along with the above template.

```
module People
  #
  class New < FormView
    include Wrapper::People::Form

    def labeled_simple_form
      mustache_simple_form_for(@person, url: {controller: "people", action: "create"}) do |f|
        simple_form_common(f)
      end
    end

  end
end
```

The example code here is taken from one of my projects that is using the Stache gem and hence I have a small
class that wraps that gem.. which is what the above view class inherits from. The important piece here is the
included module "MustacheForm::FormHelper". This has all the smarts to wrap the standard rails form_helper methods
and also the simple_form ones which are also used in this example. You would simply include this module in your
view class..

```
class FormView < ::Stache::Mustache::View
  include MustacheForm::FormHelper
end
```

Finally the form module that is included in the above New class. The form_helper yields to this method and
it returns a hash (data pair) with the field names and values that are then forwarded with the form_tag smarts
to the Mustache render method to finally create the complete view. The biggest win here being that we have complete
separation of concerns between the view class and the logicless Mustache template!

```
module People
  module Form

    def simple_form_common(f)
      {
        first_name_field: f.input(:first_name),
        last_name_field: f.input(:last_name),
        email_address_field: f.input(:email_address),
        mobile_phone_field: f.input(:mobile_phone),
        home_phone_field: f.input(:home_phone),

        # Submit
        cancel_button: cancel_button,
        submit_button: submit_button(f),
      }
    end

    def submit_button(f)
      object_name = f.object.class.to_s.underscore.pluralize
      f.button :submit, t("#{object_name}.new.submit"), class: "#{PRIMARY_ACTION_BUTTON_CLASS}"
    end

```

#### SimpleForm - Simple Fields For

**Simple Form** also comes with some extra helpers you can use inside rails default forms without relying
on `simple_form_for` helper. They are listed below.

Wrapper to use **Simple Form** inside a default rails form. It works in the same way that the `fields_for`
Rails helper, but change the builder to use the `SimpleForm::FormBuilder`.

```ruby
form_for @user do |f|
  f.simple_fields_for :posts do |posts_form|
    # Here you have all simple_form methods available
    posts_form.input :title
  end
end
```

**Mustache Form** should support these as we are simply yielding to your view method that contains the inputs
during the process and hence you should be able to use these - though I would caution that I have not had the
chance to test this feature.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mustache_form.
