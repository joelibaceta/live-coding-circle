
require 'net/ssh'

class Session

    attr_accessor :hashcode
    attr_accessor :terminal
    attr_accessor :ssh_connection

    Terminal = Struct.new("PTYTerminal", :reader, :writer, :pid)

    SSHConnection = Struct.new("SSHConnection", :host, :user, :password, keyword_init: true)

    def initialize(hashcode=nil)
        @hashcode = hashcode || SecureRandom.alphanumeric(8)
    end

    def start(actioncable_channel, session_id, channel_ext)
 

        Net::SSH.start( @ssh_connection.host, @ssh_connection.user,  password: @ssh_connection.password ) do |session|

            session.open_channel do |channel| 

                ActionCable.server.broadcast(
                    "terminal_#{session_id}", 
                    "Channel openned succefully"
                )

                channel_ext[0] = channel
                
                channel.on_data do |ch,data|
                    puts data
                end
                
                channel.on_close do
                    ActionCable.server.broadcast(
                        "terminal_#{session_id}", 
                        "shell terminated"
                    )
                end
 

            end
            
            session.loop

        end
 
    
    end

end

