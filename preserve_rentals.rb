require 'json'

# rubocop:disable Metrics

module PreserveRentalsData
  def store_rentals(rentals)
    file = './data_store/rentals.json'

    # Read the contents of the file and handle empty file / invalid JSON cases
    begin
      data = File.exist?(file) ? JSON.parse(File.read(file)) : []
    rescue JSON::ParserError, Errno::ENOENT
      data = []
    end

    new_rentals = []
    rentals.each do |rental|
      next if data.any? do |existing_rental|
                existing_rental['person'] == rental.person.name && existing_rental['booktitle'] == rental.book.title &&
                existing_rental['bookauthor'] == rental.book.author
              end

      new_rentals << { date: rental.date, booktitle: rental.book.title, bookauthor: rental.book.author,
                       person: rental.person.name }
    end

    data.delete_if do |existing_rental|
      existing_rental['booktitle'] == new_rentals.last[:booktitle] &&
        existing_rental['bookauthor'] == new_rentals.last[:bookauthor]
    end
    data += new_rentals.last(1)
    File.write(file, JSON.pretty_generate(data))
  end

  def load_rentals
    file = './data_store/rentals.json'
    return [] unless File.exist?(file)

    if File.zero?(file)
      []
    else
      JSON.parse(File.read(file)).map do |rental|
        Rental.new(rental['date'], Book.new(rental['booktitle'], rental['bookauthor']), Person.new(rental['person']))
      end
    end
  end
end

# rubocop:enable Metrics
