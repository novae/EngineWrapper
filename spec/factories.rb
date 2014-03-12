FactoryGirl.define do
	factory :usuario do
		sequence(:nombre)	{ |n| "alumno #{n}"}
		sequence(:email)	{ |n| "alumno_#{n}@ITCG.com"}
		password 				"Jcgr112388"
		password_confirmation	"Jcgr112388"
	end
end