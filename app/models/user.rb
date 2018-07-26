class User < ApplicationRecord
    belongs_to :snippet
    has_many :messages
end
