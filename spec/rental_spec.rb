require 'yaml'
require './rental'

describe Rental do
    before :each do
      @book = Book.new('Wuthering Heights', 'Emily Bronte')
      @person = Person.new(25, 'John Doe')
      @rental = Rental.new('2022-04-18', @book, @person)
    end
  
    describe '#initialize' do
      it "sets date to 2022-04-18" do
        expect(@rental.date).to eq '2022-04-18'
      end
    end
  
    describe '#book' do
      it "returns the rented book" do
        expect(@rental.book).to eq @book
      end
    end
  
    describe '#person' do
      it "returns the person who rented the book" do
        expect(@rental.person).to eq @person
      end
    end
  end