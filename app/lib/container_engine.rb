require 'pty'

module ContainerEngine
    
    mattr_accessor :containers

    def start_container(hashcode, language)
        @@containers = Hash.new unless @@containers
        unless  @@containers[hashcode]
            @@containers[hashcode] = Container.new(hashcode, language) 
        end
        @@containers[hashcode]
    end
    module_function :start_container 

    def get_container(hashcode)
        return @@containers[hashcode] rescue nil
    end
    module_function :get_container

    def get_or_create_container(hashcode)
        return @@containers[hashcode] || Container.new(hashcode, language)
    end
    module_function :get_or_create_container

    class Container
        attr_accessor :image
        attr_accessor :language
        attr_accessor :reader
        attr_accessor :writer
        attr_accessor :hashcode


        def initialize(hashcode=nil, language)
            @hashcode = hashcode || SecureRandom.alphanumeric(8)
            @language = language 
        end

        def start
            @semaphore = Mutex.new
            Thread.start do
                @semaphore.synchronize {
                    PTY.spawn(" docker run --name #{@hashcode} -it #{@language} /bin/bash") do |reader, writer, pid|
                        @writer = writer
                        @reader = reader
                    end
                }
            end
        end

        def putc(data)
            @writer.puts(data)
        end

    end

end