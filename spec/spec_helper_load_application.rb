# in the real rails app this will happen in the initializer
MustacheForm.setup do |config|
  config.simple_form_enabled = true
end
#
module TestMustacheFormApp
  class Application < ::Rails::Application
    puts "\n\n MustacheForm TestApp: Rails Starting...\n\n"
  end
end
#
TestMustacheFormApp::Application.config.secret_token = '1234567890123456789012345678901234567890'
TestMustacheFormApp::Application.config.secret_key_base = '1234567890123456789012345678901234567890'
TestMustacheFormApp::Application.initialize!
#
