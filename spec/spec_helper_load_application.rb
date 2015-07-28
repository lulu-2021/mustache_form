# Setup a test app
#
module TestMustacheFormApp
  class Application < ::Rails::Application
    # This is the only configuration requirement for the mustache_form gem
    puts "\n\n MustacheForm TestApp: Rails Starting...\n\n"
    config.mustache_form.simple_form_enabled = true
  end
end
#
TestMustacheFormApp::Application.config.secret_token = '1234567890123456789012345678901234567890'
TestMustacheFormApp::Application.config.secret_key_base = '1234567890123456789012345678901234567890'
TestMustacheFormApp::Application.initialize!
#
#
#
