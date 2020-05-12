module ChallengesHelper
  def challenge
    @challenge ||= Challenge.new
  end

  def active_challenge? challenge
    Date.today <= challenge.deadline - challenge.duration
  end

  def commenter_name comment
    if comment.user_id == @challenge.owner_id
      "@#{comment.user.name} (owner*)"
    else
      "@#{comment.user.name}"
    end
  end

  def remove_user_participation challenge_id
    ParticipateIn.where(challenge_id: challenge_id).destroy_all
    Favorite.where(challenge_id: challenge_id).destroy_all
    Favorite.where(challenge_id: challenge_id).destroy_all
  end
end
