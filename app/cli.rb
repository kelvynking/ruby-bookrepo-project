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

    # Provide an interface to allow a user to Show all users, Add user, Login, Logout and Exit current menu.
    def userFunctions
        continue = 'y'
            
        while continue == 'y'

            puts ''
            puts 'User Menu'
            puts '---------'
            puts ''
            puts '1. Show Users'
            puts '2. Add User'
            puts '3. Login User'
            puts '4. Logout User'
            puts '5. Exit User Menu' 
            
            input = gets.strip

            if input == '1'
                showUsers
            elsif input == '2'
                addUser
            elsif input == '3'
                loginUser
            elsif input == '4'
                logoutUser
            elsif input == '5'
                continue = 'n'
            else 
                puts "The option wasn't recognised. Please try again."
            end
        end
    end

    #Method to show all users
    def showUsers
        puts 'Current Users'
        puts '-------------'
        puts ''
    end

    #Method to add user to the database
    def addUser
        continue = 'y'
            puts 'Add User Menu'
            puts '-------------'
            puts ''
            puts 'Adding user to database'
            puts ''
        while continue = 'y'
            puts ''
            print 'Type username: '
            username = gets.strip
            print 'Type password: '
            password = gets.strip
            print 'Type email: '
            email = gets.strip

            #Check to see if the user has entered something for both the username and password fields

            if !username.empty? && !password.empty?

                #Check to see if there is a user with the given username. If not, create one.
                current_user = User.find_or_create_by(username: username)

                if current_user
                    puts 'There is already a user with this username'
                    puts 'Please choose another username.'
                else
                    User.create(username: username, password: password, email: email)
                    continue = 'n'
                end
            else
                puts 'You need to add a username and password.'
            end
        end
    end
end