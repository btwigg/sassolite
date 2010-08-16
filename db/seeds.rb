# Create an admin user
User.create(:login => "admin", :password => "password", :password_confirmation => "password", :name => "Admin User", :initials => "AU", :email => "admin@example.com")

ProjectType.create(:name => "Time & Maintenance")
ProjectType.create(:name => "Not Billable/Internal")
ProjectType.create(:name => "Fixed Price")

AddressType.create(:name => "Mailing")
AddressType.create(:name => "Billing")

ProjectNumber.create(:code => 5959)