module GoodsHelper
  def user_added_to_opinion? user, good
    user.opinions.where(user: user, good: good).any?
  end
end
