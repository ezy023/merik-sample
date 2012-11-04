desc "This will send out the next batch of invites for the beta"
task :send_invites => :environment do
  limit = 10
  invitation = Invitation.all(:conditions => { :sent_at => nil, :sender_id => nil }, :limit => limit).each do |i|
    Mailer.invitation(i, "http://localhost:3000/signup/#{i.token}").deliver
    i.sender_id = 0
    puts "Sent invitation to #{i.recipient_email}."
  end


end