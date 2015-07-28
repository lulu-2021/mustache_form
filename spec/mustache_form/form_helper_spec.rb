require 'spec_helper'
#
require 'form_helper'
#
class MockFormHelper
  include Mustache::FormHelper
end
#
describe MockFormHelper do
  let(:subject) { MockFormHelper.new }

  it 'has the correct rails form helper methods' do
    expect(subject).to respond_to(:custom_form_for)
    expect(subject).to respond_to(:custom_form_tag)
  end

  it 'has the correct simple_form form helper methods' do
    expect(subject).to respond_to(:custom_simple_form_for)
    expect(subject).to respond_to(:custom_simple_form_tag)
  end
end
