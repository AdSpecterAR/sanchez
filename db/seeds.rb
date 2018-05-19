# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
	first_name: 'John',
	last_name: 'Wooden',
	account_type: 'developer',
	username: 'JohnWooden',
	email: 'JohnWooden@ucla.edu',
	password: 'uclanumberoneuc'
)
p 'Created a User' 

AdUnit.create(
	title: 'default',
	description: 'default ad for testing',
	click_url: 'https://www.adspecter.com',
	ad_unit_url: 'https://naotw-pd.s3.amazonaws.com/coke_holiday_ooh_aotw.jpg',
	active: true,
	user_id: 1
)
p 'Created an AdUnit'
