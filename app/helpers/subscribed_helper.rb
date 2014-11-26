module SubscribedHelper

  def subscribed?(result)
    if current_user.has_feed?(result.id.to_s)
      true
    else
      false
    end
  end

end
