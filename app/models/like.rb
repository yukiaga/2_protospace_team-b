class Like < ActiveRecord::Base
  belongs_to :prototype, counter_cache: :likes_count
  belongs_to :user

  # def like_user(user_id)
  #   likes.find_by(user_id: user_id)
  # end

end

