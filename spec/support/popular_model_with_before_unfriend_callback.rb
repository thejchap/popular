class PopularModelWithBeforeUnfriendCallback < PopularModel
  before_unfriend :callback_worked

  def callback_worked
    true
  end
end
