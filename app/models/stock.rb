class Stock < ActiveRecord::Base
	validates :ticker, :current_price, presence: true
	validates :current_price, numericality: true
	validates :ticker, uniqueness: true
end
