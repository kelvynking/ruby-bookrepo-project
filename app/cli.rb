class CLI
    def initialize
        continue = 'y'
            puts ''
            puts 'WELCOME TO MY BOOK REPOSITORY COMMAND LINE INTERFACE'
            puts ''
        while continue == 'y' 
            puts ''
            puts 'Main Menu'
            puts '---------'
            puts ''
            puts 'Select a function:'
            puts ''
            puts "1. User"
            puts "2. Keyword Search"
            puts "3. Genre Search"
            puts "4. Show Favorites"
            puts "5. Exit"
            puts ''
            print 'Choose options 1 through 5: '

            input = gets.strip

            if input == '1'
                userFunctions
            elsif input == '2'
                keywordSearch
            elsif input == '3'
                genreSearch
            elsif input == '4'
                showFavourites
            elsif input == '5'
                puts 'You have now exited the app. Thank you and have a great day!'
                continue = 'n'
            else
                puts 'Sorry. I did not understand that option. Please try again.'
            end
        end
    end
end