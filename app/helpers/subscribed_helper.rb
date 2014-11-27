module SubscribedHelper

  def subscribed?(result_id)
    if current_user.has_feed?(result_id.to_s)
      true
    else
      false
    end
  end

end
