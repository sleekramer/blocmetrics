Event.destroy_all
RegisteredApplication.where.not(id: 2).destroy_all

5.times do
  RegisteredApplication.create!(
    name: Faker::Lorem.sentence(2, true, 4),
    url: Faker::Internet.url,
    user: User.first
  )
end
registered_applications = RegisteredApplication.all
events = ["login", "logout", "item created", "picture clicked", "item deleted", "item edited", "page visited", "link clicked"]
200.times do
  event = Event.create!(
    name: events.sample,
    registered_application: registered_applications.sample
  )
  event.update_attribute(:created_at, rand(0.day .. 1.month).ago)
end

puts "Finished."
puts "#{User.count} users in database."
puts "#{RegisteredApplication.count} applications in database."
puts "#{Event.count} events in database."
