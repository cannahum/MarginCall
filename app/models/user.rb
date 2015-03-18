class User < ActiveRecord::Base
	has_many :triggers
	attr_accessor :remember_token
	before_save { self.email1 = email1.downcase }
	validates :name, presence:true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :email1, presence: true, length: { maximum: 255 },  uniqueness: true,
			format: { with: VALID_EMAIL_REGEX }
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine::cost
		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
end
