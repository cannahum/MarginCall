class Trigger < ActiveRecord::Base
	belongs_to :user
	validates  :ticker, :trigger_price, presence: true
	validates :trigger_price, numericality: { greater_than_or_equal_to: 0.01 }
end
