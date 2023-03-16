require 'yaml'
require './capitalize_decorator'

describe CapitalizeDecorator do
  before :each do
    @nameable = instance_double('Nameable', correct_name: 'john')
    @decorator = CapitalizeDecorator.new(@nameable)
  end

  describe '#correct_name' do
    it "capitalizes the nameable's correct_name" do
      expect(@decorator.correct_name).to eq 'John'
    end
  end
end
