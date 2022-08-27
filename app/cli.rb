class CLI

    def graphics
        system("clear")
        puts ''
        puts '██████╗  ██████╗  ██████╗ ██╗  ██╗██████╗ ███████╗██████╗  ██████╗'
        puts '██╔══██╗██╔═══██╗██╔═══██╗██║ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔═══██╗'
        puts '██████╔╝██║   ██║██║   ██║█████╔╝ ██║  ██║█████╗  ██████╔╝██║   ██║'
        puts '██╔══██╗██║   ██║██║   ██║██╔═██╗ ██║  ██║██╔══╝  ██╔═══╝ ██║   ██║'
        puts '██████╔╝╚██████╔╝╚██████╔╝██║  ██╗██████╔╝███████╗██║     ╚██████╔╝'
        puts '╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝      ╚═════╝ '
        puts ''                                                               
    end

    def initialize
        @loggedinuser = LoggedInUser.new

        continue = 'y'
        while continue == 'y'
            graphics
            puts ''
            puts 'WELCOME TO MY BOOK REPOSITORY COMMAND LINE INTERFACE'
            puts ''
            puts "You are currently logged in as #{@loggedinuser.username}" if @loggedinuser.loggedin == true
            puts ''
            puts 'Main Menu'
            puts '---------'
            puts ''
            puts 'Select a function:'
            puts ''
            puts "1. User"
            puts "2. Genre Search"
            puts "3. Show Favorites"
            puts "4. Exit"
            puts ''
            print 'Choose options 1 through 4: '

            input = gets.strip

            if input == '1'
                userFunctions
            elsif input == '2'
                genreSearch
            elsif input == '3'
                showFavourites
            elsif input == '4'
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
        graphics    
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
            print "Please choose an option between 1-5: "
            
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
        graphics  
        puts 'Current Users'
        puts '-------------'
        puts ''
        current_users = User.all()
        current_users.each do |user|
            puts "#{user.username} - #{user.email}"
        end
    end

    #Method to add user to the database
    def addUser
        continue = 'y'
            graphics  
            puts 'Add User Menu'
            puts '-------------'
            puts ''
            puts 'Adding user to database'
            puts ''
        while continue == 'y'
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
                current_user = User.where(username: username).first
                if current_user
                    puts 'There is already a user with this username'
                    puts 'Please choose another username.'
                else 
                    current_user = User.create(username: username, password: password, email: email)
                    continue = 'n'
                end
            else
                puts 'You need to add a username and password.'    
            end
        end
    end

    def loginUser
        graphics  
        puts 'Login User Menu'
        puts '---------------'
        puts ''
        print 'Type in your username: '
        username = gets.strip
        print 'Type in your password: '
        password = gets.strip

        if !username.empty? && !password.empty?
            user = User.where(username: username, password: password).first
            if user
                user.loggedin = true
                user.save()
                @loggedinuser.username = username
                @loggedinuser.loggedin = true
                puts "Hi, you are now logged in as #{user.username}"
            else
                puts "Sorry your username and/or password information is incorrect"
            end
        else
            puts "Please enter a valid username and password."
        end
    end

    def logoutUser
        graphics 
        username = @loggedinuser.username
        user = User.where(username: username).first
        if user
            user.loggedin = false
            user.save()
            @loggedinuser.loggedin = false
            puts "You are now logged out."
            puts "Press enter to continue..."

            gets
        else
            puts "User isn't logged in."
        end  
    end

    def genreSearch
        graphics  
       if Genre.all.count == 0
            scraper = Scraper::GenreScraper.new
            scraper.add_genres_to_database
        end
        Genre.all.each do |genre|
            puts "#{genre.id}: #{genre.name}"
        end
        puts ''
        print 'Choose a number: '
        input = gets.strip
        return if input.empty?


        genre_name = Genre.find(input.to_i)
        scraper = Scraper::GenreBookScraper.new(genre_name.name)
        scraper.show_books
        puts 'Currently saved books'
        puts '---------------------'
        puts ''
        Book.where(genre: genre_name.name).each do |book|
            puts "#{book.id} : #{book.title}"
        end
        puts ''
        print 'Please make a selection: '
        puts ''
        input = gets.strip

        get_book_info(input.to_i)
    end

    def get_book_info(book_id)
        continue = "y"
        while continue == "y"
            graphics
            book = Book.find(book_id)
            google_API = GoogleBooksAPI.new(book.title)
            response =  JSON.parse(google_API.query)
        
            item = response["items"][0]
            author = item["volumeInfo"]["authors"][0]
            description = item["volumeInfo"]["description"]
            pages = item["volumeInfo"]["pageCount"]

            book.author = author
            book.description = description
            book.num_pages = pages
            book.save()

            puts "Book Information"
            puts "----------------"
            puts "Author: #{author}"
            puts ""
            puts "Description: #{description}"
            puts ""
            puts "Number of Pages: #{pages}"
            puts " "
            print "Would you like to save this book as a favourite? Enter [y]es or [n]o: "
            input = gets.strip

            if @loggedinuser.loggedin == true 
                if input == 'y'
                    book.favorite = true
                    book.save()
                end
                continue = 'n'
            else
                puts "You are not logged in. Please log in."
                continue = 'n'
            end
        end
    end

    def showFavourites
        continue = 'y'
        
        while continue == 'y'
            graphics
            if @loggedinuser.loggedin == true
                puts ""
                puts "These are your favourite books:"
                puts "-------------------------------"
                
                Book.where(favorite: true).each do |book|
                    puts book.title
                end
                puts "Press any key to continue..."

                gets
                continue = 'n'
            else
                puts "You are currently not logged in. Please log in to see your favourite books."
                
                puts "Press any key to continue..."
                gets
                continue = 'n'
            end
        end
    end
end
