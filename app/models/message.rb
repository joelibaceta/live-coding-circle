class Message < ApplicationRecord
    belongs_to :snippet
    belongs_to :user
end
