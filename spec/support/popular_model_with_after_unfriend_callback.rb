class PopularModelWithAfterUnfriendCallback < PopularModel
  after_unfriend :callback_worked

  def callback_worked
    true
  end
end
