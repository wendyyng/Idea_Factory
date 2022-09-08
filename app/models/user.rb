class User < ApplicationRecord
    has_many :ideas, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_secure_password

    has_many :likes, dependent: :destroy
    
    def full_name
        self.first_name + " " + self.last_name
    end
end
