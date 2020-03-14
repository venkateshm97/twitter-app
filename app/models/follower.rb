class Follower < ApplicationRecord
   belongs_to :user
   validates :user_id, :on => :create, uniqueness: {
    scope: [:user_id ,:follow_to],
    message: ->(object, data) do
      "Already Following"
    end
  }
end
