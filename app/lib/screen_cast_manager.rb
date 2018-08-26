require 'open3'

require 'pty'

module ScreenCastManager

    mattr_accessor  :casts

    def start_broadcast(hashcode)

        @@casts = Hash.new unless @@casts
        unless  @@casts[hashcode]
            uri = "rtmp:///live/#{hashcode}.sdp"
            puts "Broadcasting Screen at #{uri}"
            @@casts[hashcode] = ScreenCast.new(uri) 
        end
        @@casts[hashcode]

    end
    module_function :start_broadcast

    def get_broadcast(hashcode)
        return @@casts[hashcode] rescue nil
    end
    module_function :get_broadcast


    class ScreenCast
        attr_accessor :read
        attr_accessor :write
        attr_accessor :pid

        def initialize(uri) 

            @semaphore = Mutex.new

            Thread.start do
                @semaphore.synchronize { 

                    ffmpeg_command = "ffmpeg"
                    ffmpeg_command += " -i - " # read input video from STDIN
                    ffmpeg_command += " -vcodec copy" # encoding H.264
                    ffmpeg_command += " -f flv " # FLV as container format used in conjunction with RTMP
                    ffmpeg_command += " test.flv"

                    puts ffmpeg_command 

                    #@pid = spawn(ffmpeg_command)
                    master, slave = PTY.open
                    read, write = IO.pipe

                    pid = spawn(ffmpeg_command, in: read, :out=>slave) # write mode
                    read.close
                    slave.close
                    @write = write
                    puts @write
                    #@write, x = Open3.pipeline_w(ffmpeg_command)

                }
            end
            
        end

        def send_data(data)
            puts @write
            @write.puts(data)
        end

    end

end