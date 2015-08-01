#
require 'spec_helper_railtie'
require 'i18n'
#
require 'mustache_form'
require 'spec_helper_load_application'
require 'mustache_form/railtie'
#
describe MustacheForm::Railtie do
  it 'after initialisation the App should have the mustache_form gem configured' do
    expect(MustacheForm.simple_form_enabled).to eq true
  end
end
