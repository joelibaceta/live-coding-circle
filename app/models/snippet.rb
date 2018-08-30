class Snippet < ApplicationRecord 

    after_save :update_related_file

    def update_related_file
        # Dir.mkdir("middleware/snippets/#{slug}") unless Dir.exist?("middleware/snippets/#{slug}")
        # file = File.open("middleware/snippets/#{slug}/#{title}", "w+")
        # file.write(code)
        # file.close
    end

end