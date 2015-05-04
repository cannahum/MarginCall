# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


	# User.delete_all
	# User.create!(f_name:"Jon", l_name:"Nahum", p_number:"617-909-7873", email1:"cannahum@brandeis.edu", email2:"cannahum@outlook.com")
	# User.create!(f_name:"Saul", l_name:"Tbeile", p_number:"917-922-3453", email1:"cannahum@gmail.com", email2:"cannahum@outlook.com")


Trigger.delete_all
#Trigger.create(userEmail:"cannahum@outlook.com", ticker:"AAPL", trigger_price:100.00)
#Trigger.create(userEmail:"cannahum@outlook.com", ticker:"MSFT", trigger_price:50.00)
#Trigger.create(userEmail:"cannahum@outlook.com", ticker:"GE", trigger_price:70.00)


Stock.delete_all
Stock.create(ticker:'AAPL', current_price: 110)
#Stock.create(ticker:'MSFT', current_price: 0)
#Stock.create(ticker:'GE', current_price: 0)

HistoricalStockPrice.delete_all
date = '05/01/2015'
hour = '11'
minute = '00';
morning = 'am'

(0..50).each do |iteration|
	puts iteration
	
	HistoricalStockPrice.record_historical_price(Stock.first, date, hour + ':' + minute + morning)
	Stock.first.update(:current_price => (Stock.first.current_price * 1.01))
	
	minute = ((minute.to_i) + 1)
	if minute <= 9
		minute = '0' + minute.to_s
	else
		minute = minute.to_s
	end
end
