#
require 'spec_helper_railtie'
require 'i18n'
#
require 'mustache_form'
require 'spec_helper_load_application'
#
describe MustacheForm::Railtie do
  it 'after initialisation the App should have the mustache_form constants module configured' do
    expect(Rails.application.config.mustache_form[:simple_form_enabled]).to eq true
  end
end
