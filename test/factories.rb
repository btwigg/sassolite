Factory.define :address_type do |t|
  t.name "Mailing"
end

Factory.define :address do |a|
  a.name "James T. Kirk"
  a.address1 "NCC 1701 Enterprise"
  a.address2 "P.O. Box A"
  a.city "Riverside"
  a.state "Iowa"
  a.zipcode "17010"
  a.phone "1-701-170-1000"
  a.fax "1-701-170-1001"
  a.email "james.tiberius.kirk@ufop.example.com"
  a.association :address_type
  a.association :client
end

Factory.define :client do |c|
  c.name "Quentin Corp"
end

Factory.define :project_type do |t|
  t.name "Time & Maintenance"
end

Factory.define :project do |p|
  p.code 1701
  p.name "Space Seeding"
  p.association :project_manager, :factory => :user
  p.association :project_type
end

Factory.define :project_number do |n|
  n.code 5959
end

Factory.define :project_duration do |d|
  d.start { Time.now - 1.week }
  d.end { Time.now + 1.week }
  d.hours_allocated 80
  d.hours_elapsed 40
  d.notes "Duration notes"
  d.association :project
end

Factory.define :user do |u|
  u.login "sampleUser"
  u.initials "SU"
  u.name "Sample User"
  u.email "sample.user@example.com"
  u.password "password"
  u.password_confirmation "password"
end

Factory.define :status_update do |u|
  u.entry_date { Date.today }
  #u.association :user
  u.association :project_duration
  u.description "Lorem ipsom dolar"
end

