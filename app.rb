require_relative './person'
require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'
require_relative './classroom'
require_relative './preserve_books'
require_relative './preserve_people'
require_relative './preserve_rentals'

# rubocop:disable Metrics

class App
  attr_accessor :people, :books, :rentals

  include PreserveBooksData
  include PreservePeopleData
  include PreserveRentalsData

  def initialize
    @people = load_people
    @books = load_books
    @rentals = load_rentals
  end

  def list_all_books
    if @books.empty?
      puts 'The book list is currently empty.'
    else
      puts 'Existing books:'
      @books.each_with_index do |book, index|
        puts "#{index + 1} - [Book] Title: #{book.title} | Author: #{book.author}"
      end
    end
    sleep 0.5
  end

  def list_all_people
    if @people.empty?
      puts 'The people\'s list is currently empty.'
    else
      puts 'Existing list of people:'
      @people.each_with_index do |persn, index|
        puts "#{index + 1} - [Student] Id: #{persn.id} Name: #{persn.name} Age: #{persn.age}" if persn.is_a?(Student)
        puts "#{index + 1} - [Teacher] Id: #{persn.id} Name: #{persn.name} Age: #{persn.age}" if persn.is_a?(Teacher)
      end
    end
    sleep 0.5
  end

  def create_a_person
    print 'Do you want to create a student (1) or teacher (2) [Input a number]: '
    option = gets.chomp.to_i

    case option
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid option. Please enter 1 or 2'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i

    print 'Classroom: '
    classroom = gets.chomp

    print 'Name: '
    name = gets.chomp

    print 'Has parent permission. [Y/N]: '
    parent_permission = gets.chomp.capitalize
    case parent_permission
    when 'Y'
      student = Student.new(age, classroom, name, true)
      @people << student
    when 'N'
      student = Student.new(age, classroom, name, false)
      @people << student
    else
      puts 'Invalid entry'
    end
    puts 'Student created successfully'
    store_people(@people)
    sleep 0.5
  end

  def create_teacher
    puts 'Age:'
    age = gets.chomp.to_i

    puts 'Specialization:'
    specialization = gets.chomp

    puts 'Name:'
    name = gets.chomp

    teacher = Teacher.new(specialization, age, name)
    @people << teacher

    puts 'Teacher created successfully'
    store_people(@people)
    sleep 0.5
  end

  def create_a_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts 'Book added successfully'
    store_books(@books)
    sleep 0.5
  end

  def create_a_rental
    if @books.empty? && @people.empty?
      puts 'Sorry, there is nothing here'
    else
      puts 'Select a book from the following list by number'
      @books.each_with_index do |book, index|
        puts "#{index} - [Book] Title: #{book.title} | Author: #{book.author}"
      end
      book_num = gets.chomp.to_i
      book_rented = @books[book_num]

      puts 'Select a person from the following list by number (not id)'
      @people.each_with_index do |person, index|
        puts "#{index} - [Student] Id: #{person.id} Name: #{person.name} Age: #{person.age}" if person.is_a?(Student)
        puts "#{index} - [Teacher] Id: #{person.id} Name: #{person.name} Age: #{person.age}" if person.is_a?(Teacher)
      end
      person_num = gets.chomp.to_i
      person_renting = @people[person_num]

      print 'Enter date of renting the book (yyyy-mm-dd): '
      date = gets.chomp.to_s

      rental = Rental.new(date, book_rented, person_renting)
      @rentals << rental
      puts 'Rental created successfully'
    end
    store_rentals(@rentals)
    sleep 0.5
  end

  def list_rentals
    if @rentals.empty?
      puts 'There are no rentals available currently'
    else
      print 'Let\'s find your book. Type Id of person: '
      id = gets.chomp.to_i
      rentals_of_individual = @rentals.select { |rental| rental.person.id == id }
      if rentals_of_individual.empty?
        puts 'There is no rental matching the given Id'
      else
        puts 'Here are the rentals matching the given Id:'
        rentals_of_individual.each.with_index do |rental, index|
          if rental.person.is_a?(Student)
            puts "#{index + 1} - Date: #{rental.date}, Borrower[Student]: #{rental.person.name} |
            Book: #{rental.book.title} by #{rental.book.author}"
          end
          if rental.person.is_a?(Teacher)
            puts "#{index + 1} - Date: #{rental.date}, Borrower[Teacher]: #{rental.person.name} |
            Book: #{rental.book.title} by #{rental.book.author}"
          end
        end
      end
    end
    sleep 0.5
  end
end

# rubocop: enable Metrics
