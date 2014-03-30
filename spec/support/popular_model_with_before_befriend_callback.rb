class PopularModelWithBeforeBefriendCallback < PopularModel
  before_befriend :callback_worked

  def callback_worked
    true
  end
end
