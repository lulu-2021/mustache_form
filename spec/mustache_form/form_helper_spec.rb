require 'spec_helper'
require 'form_helper'
#
class DummyHtmlSafe
  def initialize(text, obj); @text = text; @obj = obj; end
  def html_safe
    @obj[:value] if @text = @obj[:key]
  end
end
#
class Mustache
  def render(text, obj); DummyHtmlSafe.new(text, obj); end
end
#
class MockFormView < Mustache
  include MustacheForm::FormHelper

  def test_form
    custom_form_tag do |form|
      { key: form[:key], value: form[:value] }
    end
  end

  # - Mock the form_tag since we are only interested in passing the values through..
  def form_tag(url: nil, html: nil, &block)
    yield({ key: 'first_name', value: 'Jo' })
  end
end
#
describe MockFormView do
  let(:subject) { MockFormView.new }

  it 'can call the form_helper' do
    input_value, expected_value = "first_name", "Jo"

    # Mustach calls the lambda expression in the form function for us - in this test we need to call it!
    expect(subject.test_form.call(input_value)).to eq expected_value
  end

  it 'has the correct rails form helper methods' do
    expect(subject).to respond_to(:custom_form_for)
    expect(subject).to respond_to(:custom_form_tag)
  end

  it 'has the correct simple_form form helper methods' do
    expect(subject).to respond_to(:custom_simple_form_for)
    expect(subject).to respond_to(:custom_simple_form_tag)
  end
end
