# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :username, :session_token, presence: true 
    validates :username, uniqueness: true 
    validates :password, length: {minimum:6, allow_nil: true}

    before_validation :ensure_session_token
    attr_reader :password
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user 
        else
            return nil 
        end
    end
            

 
    def generate_unique_token 
        #keep generating session tokens until a unique one exists
        loop do 
            session_token = SecureRandom::urlsafe_base64(16)
            return session_token unless User.exists?(session_token: session_token)
        end
    end


    def password=(password)
        @password= password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        #need to set a password_object that can check if a password matches
        #needs to be a instance to run the is password method. 
        password_object.is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= generate_unique_token
    end

    def reset_session_token
        self.session_token = generate_unique_token
        self.save!
        self.session_token 
    end

end
