require 'csv'

users_csv = File.read(Rails.root.join('lib', 'users.csv'))
users_csv_parse = CSV.parse(users_csv, :headers => true, :encoding => 'ISO-8859-1')

users_csv_parse.each do |row|
	u = User.new
	u.username = row['username']
	u.email = row['email']
	u.phone = row['phone']
	u.save
end

puts "Total users count : #{User.count}"


events_csv = File.read(Rails.root.join('lib', 'events.csv'))
events_csv_parse = CSV.parse(events_csv, :headers => true, :encoding => 'ISO-8859-1')

events_list = events_csv_parse['users#rsvp']
user_events = {}


events_list.each {|event| event&.split(";")&.each {|item| user_events[item.split("#")[0]] = item.split("#")[1]}}
events_list.first.split(";").each { |item| user_events[item.split("#")[0]] = item.split("#")[1] }
# puts user_events
users = User.where(username: user_events.keys.uniq)

events_csv_parse.each do |user_event|
	event = Event.new
	event.title = user_event['title'].to_s
	event.starttime = user_event['starttime'].to_s.to_datetime
	event.endtime = user_event['endtime'].to_s.to_datetime
	event.description = user_event['description'].to_s
	event.allday = user_event['allday'].to_s == "true" ? true : false
	event.completed = Date.current <= event.endtime ? false : true
	event.save
	next if user_event['users#rsvp'].nil?
	user_event['users#rsvp']&.split(";").each do |item| 
		username = item.split('#')[0]
		rsvp = item.split('#')[1]
		user = users.find_by(username: username)
		event.participations.create(user: user, event_name: event.title, entry: rsvp, completed: event.completed)
	end	
end	


puts "Total Events count: #{Event.count}"
