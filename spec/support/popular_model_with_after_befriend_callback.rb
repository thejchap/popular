class PopularModelWithAfterBefriendCallback < PopularModel
  after_befriend :callback_worked

  def callback_worked
    true
  end
end
