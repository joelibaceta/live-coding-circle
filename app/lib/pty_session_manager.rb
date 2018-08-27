
require 'net/ssh'

module PTYSessionManager

    mattr_accessor :sessions

    def start_session(hashcode)
        @@sessions = Hash.new unless @@sessions
        unless  @@sessions[hashcode]
            @@sessions[hashcode] = Session.new(hashcode) 
        end
        @@sessions[hashcode]
    end
    module_function :start_session

    def close_session(hashcode)
        session = @@sessions[hashcode]
        session.close
    end
    module_function :close_session

    def get_session(hashcode)
        return @@sessions[hashcode] rescue nil
    end
    module_function :get_session

    def get_or_create_session(hashcode)
        return @@sessions[hashcode] || Session.new(hashcode)
    end
    module_function :get_or_create_session
    
    class Session

        attr_accessor :hashcode
        attr_accessor :terminal
        attr_accessor :ssh_connection 
        attr_accessor :channel
     
        SSHConnection = Struct.new("SSHConnection", :host, :user, :password, keyword_init: true)

        def connect_to(ssh_connection)
            @ssh_connection = Net::SSH.start(
                ssh_connection.host, 
                ssh_connection.user, 
                password: ssh_connection.password,
                verify_host_key: :never
            )
        end
    
        def initialize(hashcode=nil)
            @hashcode = hashcode || SecureRandom.alphanumeric(8)
            connect_to(
                SSHConnection.new(
                    host: "167.99.239.147",
                    user: "developer",
                    password: "r3dc0d3"
                )
            )
        end

        def send_data(data)
            @channel.send_data(data)
        end

        def start(on_data: nil)
            @semaphore = Mutex.new
            Thread.start do
                @semaphore.synchronize { 
                    @channel = @ssh_connection.open_channel do |ch|
                        ch.on_data do |ch, data|
                            on_data.call(data)
                        end
                        ch.request_pty
                        ch.send_channel_request("shell")  
                        ch.on_close { puts "done!" } 
                    end  
                    @ssh_connection.loop(0.1) { true }
                }
            end
        end

        def close
            @channel.close
            @ssh_connection.close
        end
    
    end

end


