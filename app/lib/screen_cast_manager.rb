require 'open3'

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

            @read = ""
            @write = IO.pipe
 

            ffmpeg_command = "ffmpeg"
            ffmpeg_command += " -i - " # read input video from STDIN
            ffmpeg_command += " -vcodec copy" # encoding H.264
            ffmpeg_command += " -f flv" # FLV as container format used in conjunction with RTMP
            ffmpeg_command += " #{uri}"

            puts ffmpeg_command

            #@pid = spawn(ffmpeg_command)

            @read, @write, stderr, wait_tr = Open3.popen3(ffmpeg_command)
            
        end

        def send_data(data)
            @read.write(data)
        end

    end

end