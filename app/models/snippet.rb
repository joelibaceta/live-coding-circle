class Snippet < ApplicationRecord
    has_many :messages
    has_many :users
end
