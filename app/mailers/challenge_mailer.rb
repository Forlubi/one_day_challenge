class ChallengeMailer < ApplicationMailer
  def new_challenge_email
    @challenge = params[:challenge]
    @user = params[:user]

    cal = Icalendar::Calendar.new
    cal.timezone.tzid = "UTC"           
    event = Icalendar::Event.new
    event.dtstart = @challenge.deadline.days_ago(@challenge.duration)
    event.dtend = @challenge.deadline
    attendee_params = { "CUTYPE"   => "INDIVIDUAL",
                    "ROLE"     => "REQ-PARTICIPANT",
                    "PARTSTAT" => "NEEDS-ACTION",
                    # "RSVP"     => "TRUE",
                    "CN"       => "#{@user.name}",
                    "X-NUM-GUESTS" => "0" }

    attendee_value = Icalendar::Values::Text.new("MAILTO:#{@user.email}", attendee_params)
    cal.append_custom_property("ATTENDEE", attendee_value)

    # event.organizer = User.find(@challenge.owner_id).name
    event.organizer = "mailto:onedaychallege@gmail.com"
    event.organizer = Icalendar::Values::CalAddress.new("mailto:onedaychallege@gmail.com", cn: "#{@challenge.name}")
    # event.attendee = "#{@challenge.name} participants"
    event.summary = @challenge.name
    event.description = @challenge.description
    event.url = challenge_url(@challenge)
    cal.add_event(event)            
    # cal.publish
    # render :plain =>  cal.to_ical
    cal.append_custom_property('METHOD', 'REQUEST')
    mail.attachments['challenge_cal.ics'] = { :mime_type => 'text/calendar', content: cal.to_ical }

    mail(to: @user.email, subject: @challenge.name)
  end
end