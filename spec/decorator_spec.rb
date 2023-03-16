require 'yaml'
require './decorator'

describe Decorator do
    let(:nameable) { double('nameable', correct_name: 'John Doe') }
    let(:decorator) { Decorator.new(nameable) }
  
    describe '#initialize' do
      it 'sets the nameable attribute' do
        expect(decorator.nameable).to eq(nameable)
      end
    end
  
    describe '#correct_name' do
      it 'returns the correct name from the nameable object' do
        expect(decorator.correct_name).to eq('John Doe')
      end
    end
  end