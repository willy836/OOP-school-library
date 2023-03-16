require 'json'

module PreserveBooksData
  def store_books(books)
    file = './data_store/books.json'

    # Read the contents of the file and handle empty file / invalid JSON cases
    begin
      data = File.exist?(file) ? JSON.parse(File.read(file)) : []
    rescue JSON::ParserError, Errno::ENOENT
      data = []
    end

    books.each do |book|
      next if data.any? do |existing_book|
                existing_book['title'] == book.title && existing_book['author'] == book.author
              end

      data << { title: book.title, author: book.author }
    end

    File.write(file, JSON.pretty_generate(data))
  end

  def load_books
    file = './data_store/books.json'
    return [] unless File.exist?(file)

    if File.empty?(file)
      []
    else
      JSON.parse(File.read(file)).map do |book|
        Book.new(book['title'], book['author'])
      end
    end
  end
end
