
require 'net/ssh'

class Session

    attr_accessor :hashcode
    attr_accessor :terminal
    attr_accessor :ssh_connection
    attr_accessor :current_session

    Terminal = Struct.new("PTYTerminal", :reader, :writer, :pid)
    SSHConnection = Struct.new("SSHConnection", :host, :user, :password, keyword_init: true)

    def initialize(hashcode=nil)
        @hashcode = hashcode || SecureRandom.alphanumeric(8)
    end

    def start()
       @current_session = Net::SSH.start( @ssh_connection.host, @ssh_connection.user,  password: @ssh_connection.password )  
    end

end

