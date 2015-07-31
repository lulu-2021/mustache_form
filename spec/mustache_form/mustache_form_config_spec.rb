require 'spec_helper'
#
describe MustacheForm::Config do
  Given(:config) {
    MustacheForm.configure do |config|
      config.simple_form_enabled = true
    end
    MustacheForm.config
  }

  Then{ expect(config.simple_form_enabled).to eq true }
end
