class User < ActiveRecord::Base
	validates :f_name, :l_name, :email1, presence: true
end
