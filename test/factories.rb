Factory.define :client do |c|
  c.name "Quentin Corp"
end

Factory.define :project_type do |t|
  t.name "Time & Materials"
end

Factory.define :project do |p|
  p.code 1701
  p.name "Space Seeding"
  p.association :project_manager, :factory => :user
  p.project_type { ProjectType.first }
end

Factory.define :user do |u|
  u.login "sampleUser"
  u.password "password"
  u.password_confirmation "password"
end