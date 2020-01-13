require 'csv'

users_csv = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
users_csv_parse = CSV.parse(users_csv, :headers => true, :encoding => 'ISO-8859-1')

# events_csv = File.read(Rails.root.join('lib', 'seeds', 'events.csv'))
# events_csv_parse = CSV.parse(events_csv, :headers => true, :encoding => 'ISO-8859-1')

puts "wqeewqeweqweeq"
users_csv_parse.each do |row|
	puts row.to_hash
end	