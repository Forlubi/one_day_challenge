module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar), alt: user.name, class: "gravatar")
    else
      gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
  end

  def welcome(user)
  	if current_user?(user)
  		"A Warm Welcome, #{user.name}!"
  	else
  		user.name
  	end
  end

  def greeting(user)
    greeting = "Good "
    time = Time.now.hour
    if time < 12 and time > 5
      greeting += "morning"
    elsif time < 17
      greeting += "afternoon"
    elsif time < 22
      greeting += "evening"
    else
      greeting += "night"
    end
    return "#{greeting}"
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
    participation = ParticipateIn.where(user_id: user_id, challenge_id: challenge_id).first
    return participation.continuous_check_in != 0 && participation.updated_at.to_date == Date.today
  end

    # Returns true if the given user is the current user.
  def current_user?(user)
    user && user == current_user
  end
end