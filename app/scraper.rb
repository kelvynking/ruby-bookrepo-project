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
end