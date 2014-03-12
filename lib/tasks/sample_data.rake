namespace :db do 
	desc "Fill database with sample data"
	task populate: :environment do
		Usuario.create!(nombre:"Example user",
						email: "exa@example.com",
						password:"foobar",
						password_confirmation:"foobar")
		99.times do |n|
			nombre = Faker::Name.name
			email = "example-#{n+1}@example.com"
			password = "password"
			Usuario.create!(nombre:nombre,
							email: email,
							password: password,
							password_confirmation:password)
		end
	end
	
end