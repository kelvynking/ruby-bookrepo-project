module Scraper
    #Scrape the genres from GoodReads
    class GenreScraper
        def load_homepage
            Nokogiri::HTML(URI.open('https://www.goodreads.com/'))
        end

        def find_genres
            load_homepage.css('#browseBox .gr-hyperlink')
        end
    end
end