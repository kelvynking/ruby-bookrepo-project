module Scraper
    #Scrape the genres from GoodReads
    class GenreScraper

        def load_homepage
            Nokogiri::HTML(URI.open('https://www.goodreads.com/'))
        end

        def find_genres
            load_homepage.css('#browseBox .gr-hyperlink')
        end

        def add_genres_to_database
             puts 'Loading genres into the database. Please wait ...'
            find_genres.each do |g|
                new_genre = g.text.strip
                Genre.find_or_create_by(name: new_genre) do |genre|
                    genre.name = new_genre
                end
            end
        end
    end

    class GenreBookScraper
        def initialize(name)
            @name = name
        end

        def load_page
            Nokogiri::HTML(URI.open("https://www.goodreads.com/genres/most_read/#{@name.gsub(' ', '-')}"))
        end

        def find_books
            load_page.css('.bookBox')
        end

        def show_books
            puts ''
            puts "Downloading the most read books from the #{@name} genre. Please wait ..."

            find_books.each do |bbox|
               url = bbox.css('a').first['href']
               title = bbox.css('img').first['alt']
                Book.find_or_create_by(title: title) do |book|
                    book.url = url
                    book.genre = @name
                end
            end

        end
    end
end