class User < ApplicationRecord
  has_secure_password 

  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    # Remove leading/trailing whitespace from the email
    email = email.strip

    # Find the user by case-insensitive email lookup
    user = User.where('lower(email) = ?', email.downcase).first

    # If the user exists and the password is correct, return the user instance
    if user&.authenticate(password)
      return user
    else
      return nil
    end
  end
end