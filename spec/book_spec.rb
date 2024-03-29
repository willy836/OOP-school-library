require 'yaml'
require './book'
require './rental'

describe Book do
  before :each do
    @book = Book.new('Wuthering Heights', 'Emily Bronte')
    @person = Person.new('John Doe')
    @date = Date.new(2023, 0o3, 15)
  end

  describe '#initialize' do
    it 'sets book title' do
      expect(@book.title).to eq 'Wuthering Heights'
    end

    it 'sets book author' do
      expect(@book.author).to eq 'Emily Bronte'
    end
  end

  describe '#add_rental' do
    it "adds a rental to the book's rentals array" do
      @book.add_rental(@date, @person)
      expect(@book.rentals.length).to eq 1
    end

    it 'returns a rental object' do
      rental = @book.add_rental(@date, @person)
      expect(rental).to be_a(Rental)
      expect(rental.book).to eq @book
      expect(rental.person).to eq @person
      expect(rental.date).to eq @date
    end
  end
end
