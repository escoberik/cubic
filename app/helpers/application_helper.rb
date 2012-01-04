module ApplicationHelper
  def init_facebook_sdk
    render "shared/facebook_sdk"
  end

  def like_button
    render "shared/facebook_like_button"
  end
end
