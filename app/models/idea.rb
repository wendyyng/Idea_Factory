class Idea < ApplicationRecord
    belongs_to :user
    
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    
    has_many :reviews, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes,source: :user
end
