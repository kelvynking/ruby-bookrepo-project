require 'net/http'

class GoogleBooksAPI

    API_KEY = 'key=AIzaSyBUiFzZ3txNMr6BWSMypsJC0jNgWiuOjn4'

    BASE_URL = 'https://googleapis.com/books/v1/volumes?'

    def initialize(book_title)
        @search_format = "q=#{book_title.gsub(" ", "%20")}&"
    end

    def query
        uri = URI(BASE_URL + @search_format + API_KEY)

        response = Net::HTTP.get_response(uri)

        response.body
    end
end