class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :omniauthable, :recoverable, :registerable, :rememberable, :trackable, :validatable

acts_as_follower
acts_as_followable
mount_uploader :line, ImagesUploader

def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        username:     auth.info.nickname,
        avatar:     auth.info.image,
        uid:      auth.uid,
        provider: auth.provider,
        token: auth.credentials.token,
        secret: auth.credentials.secret,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user

  end


  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
