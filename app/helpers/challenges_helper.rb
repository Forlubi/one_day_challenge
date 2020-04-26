module ChallengesHelper
  def challenge
    @challenge ||= Challenge.new
  end
end
