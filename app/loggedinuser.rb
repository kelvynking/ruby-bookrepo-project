class LoggedInUser
    attr_accessor :username, :loggedin

    def initialize(username=nil, loggedin=nil)
        @username = username
        @loggedin = loggedin
    end
end