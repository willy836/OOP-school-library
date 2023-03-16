require 'yaml'
require './trimmer_decorator'

describe TrimmerDecorator do
  let(:nameable) { instance_double('Nameable', correct_name: 'William Shakespear') }
  let(:decorator) { described_class.new(nameable) }

  describe '#correct_name' do
    context 'when the name is longer than 10 characters' do
      it 'returns the first 10 characters of the name' do
        expect(decorator.correct_name).to eq('William Shakespear'.slice(0, 10))
      end
    end

    context 'when the name is shorter than or equal to 10 characters' do
      it 'returns the entire name' do
        allow(nameable).to receive(:correct_name).and_return('Jane Doe')
        expect(decorator.correct_name).to eq('Jane Doe')
      end
    end

    context 'when the name is an empty string' do
      it 'returns an empty string' do
        allow(nameable).to receive(:correct_name).and_return('')
        expect(decorator.correct_name).to eq ''
      end
    end
  end
end
