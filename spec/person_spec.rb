require 'yaml'
require './person'
require 'date'

describe Person do
    before :each do
        @person = Person.new(25, 'John')
    end

    describe '#initialize' do
    it 'sets age to 25' do
        expect(@person.age).to eq 25
    end
end

    describe '#correct_name' do
    it 'should return the correct name' do
        expect(@person.correct_name).to eq 'John'
      end
    end
    
    describe '#can_use_services?' do
    it 'person can use services?' do
        expect(@person.can_use_services?).to eq true
    end
end

    describe '#add_rental' do
    it 'should add a rental' do
        book = Book.new('Gifted Hands', 'Ben Carson')
        rental = @person.add_rental(Date.today, book)
        expect(rental.person).to eq @person
        expect(@person.rentals.size).to eq 1
        expect(@person.rentals.first).to eq rental
      end
    end

end