require 'yaml'
require './person'
require 'date'

describe Person do
    before :each do
        @person = Person.new(25, 'John')
    end

    it 'age should be 25' do
        expect(@person.age).to eq 25
    end

    it 'should return the correct name' do
        expect(@person.correct_name).to eq 'John'
      end

    # it 'should return true for of_age? when age is 18 or over' do
    #     expect(Person.new(18).of_age?).to eq true
    #   end
    
    it 'person can use services' do
        expect(@person.can_use_services?).to eq true
    end

    it 'should add a rental' do
        book = Book.new('Gifted Hands', 'Ben Carson')
        rental = @person.add_rental(Date.today, book)
        expect(rental.person).to eq @person
        expect(@person.rentals.size).to eq 1
        expect(@person.rentals.first).to eq rental
      end

end