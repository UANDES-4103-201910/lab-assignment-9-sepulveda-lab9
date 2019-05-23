class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_tickets
	has_many :tickets, :through => :user_tickets

	validates :email, presence: true, format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}, uniqueness: true

	validates :phone, length: {minimum: 9, maximum: 12}, allow_blank: true
  	validates :password, format: {with: /\A[a-zA-Z0-9\.]{8,12}\z/ , message: "password must be between 8 to 12 alphanumeric characters"}

		devise :omniauthable, :omniauth_providers => [:facebook]

		def self.new_with_session(params, session)
			super.tap do |user|
				if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
					user.email = data["email"] if user.email.blank?
				end
			end
		end

		def self.from_omniauth(auth)
			where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
				user.email = auth.info.email
				user.password = Devise.friendly_token[0,20]
				user.name = auth.info.name   # assuming the user model has a name
				user.image = auth.info.image # assuming the user model has an image
			end
		end

end
