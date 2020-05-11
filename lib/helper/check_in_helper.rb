module CheckInHelper
  class CheckInHelper
    # check if user fails to check_in a challenge
    def self.failed? participate
      return participate.updated_at != Date.today
    end
  
    # check if user already finished the challenge
    def self.finished? participate
      duration = Challenge.find(participate.challenge_id).duration
      return participate.continuous_check_in == duration
    end
  end
end