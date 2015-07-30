require 'spec_helper'
require 'form_helper'
#
MustacheForm.config.simple_form_enabled = false
#
class DummyHtmlSafe
  def initialize(text, obj); @text = text; @obj = obj; end
  def html_safe
    @obj[:value] if @text = @obj[:key]
  end
end
#
class Mustache
  # - overwrite the Mustache render method for this test!
  def render(text, obj); DummyHtmlSafe.new(text, obj); end
end
#
class MockFormView < Mustache
  include MustacheForm::FormHelper

  def test_form_tag(simple_form = false)
    custom_form_tag do |form|
      { key: form[:key], value: form[:value] }
    end
  end

  def test_form_for(object, simple_form = false)
    custom_form_for(object) do |form|
      { key: form[:key], value: form[:value] }
    end
  end

  # Mock the form_tag since we are only interested in passing the values through..
  def form_tag(url =  nil, html =  nil, &block)
    yield({ key: 'first_name', value: 'Jo' })
  end

  # Mock the form_for helper since we are only interested in passing the values through..
  def form_for(object, url = nil, html = nil, &block)
    yield({ key: object.id, value: object.name })
  end
end
#
class MockModel
  attr_accessor :id, :name
  def initialize(id, name); @id, @name = id, name; end;
end
#
describe MockFormView do
  let(:test_id) { '1234' }
  let(:test_name) { 'James' }
  let(:subject) { MockFormView.new }
  let(:test_model) { MockModel.new('1234', test_name) }
  # Mustache calls the lambda expression in the form functions for us - in these
  # tests we need to call it as we are mocking the Mustache functions

  it 'correctly handles the form_for helper' do
    input_value, expected_value = test_id, test_name
    expect(subject.test_form_for(test_model).call(input_value)).to eq expected_value
  end

  it 'correctly handles the form_tag helper' do
    input_value, expected_value = "first_name", "Jo"
    expect(subject.test_form_tag.call(input_value)).to eq expected_value
  end

  it 'has the correct rails form helper methods' do
    expect(subject).to respond_to(:custom_form_for)
    expect(subject).to respond_to(:custom_form_tag)
  end
end
