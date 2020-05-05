module ChallengesHelper
  def challenge
    @challenge ||= Challenge.new
  end

  def active_challenge? challenge
    Date.today <= challenge.deadline - challenge.duration
  end
end
