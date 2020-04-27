module UsersHelper
    # Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def welcome(user)
  	if current_user?(user)
  		"A Warm Welcome, #{user.name}!"
  	else
  		user.name
  	end
  end

  def display_by(key, users)
    
    case key
    when "coins"
      users.sort_by { |user| -user.coins }
    when "check_ins"
      users.sort_by { |user| -user.chechin_number }
    when "challenges"
      users.sort_by { |user| -user.challenge_number }
    end
  end

  def participated?(user_id, challenge_id)
    return ParticipateIn.where(user_id: user_id, challenge_id: challenge_id).size >= 1
  end

  def favorited?(user_id, challenge_id)
    return Favorite.where(user_id: user_id, challenge_id: challenge_id).size >= 1
  end

  def checkedIn?(user_id, challenge_id)
    return ParticipateIn.where(user_id: user_id, challenge_id: challenge_id).first.updated_at == Date.today
  end

    # Returns true if the given user is the current user.
  def current_user?(user)
    user && user == current_user
  end


end