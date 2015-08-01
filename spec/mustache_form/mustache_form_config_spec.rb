require 'spec_helper'
#
describe MustacheForm do
  Given(:config) {
    MustacheForm.setup do |config|
      config.simple_form_enabled = true
    end
    MustacheForm
  }

  Then{ expect(config.simple_form_enabled).to eq true }
end
