require_relative './app'



class Menu
  def initialize(app)
    @app = app
  end

  def run
    loop do
      puts 'Welcome to School Library App!'
      sleep 0.5
      puts
      puts 'Please choose an option by entering a number:'
      puts '1 - List all books'
      puts '2 - List all people'
      puts '3 - Create a person'
      puts '4 - Create a book'
      puts '5 - Create a rental'
      puts '6 - List all rentals for a given person id'
      puts '7 - Exit'
      puts

      option = gets.chomp.to_i
      case option
      when 1
        @app.list_all_books
      when 2
        @app.list_all_people
      when 3
        @app.create_a_person
      when 4
        @app.create_a_book
      when 5
        @app.create_a_rental
      when 6
        @app.list_rentals
      when 7
        puts 'Thank you for using this app!'
        exit
      else
        puts 'Invalid option, please enter a number between 1 and 7'
      end
    end
  end
end
