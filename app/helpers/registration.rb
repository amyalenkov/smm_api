class Registration

  def self.create_user(email, password)
    password_hash = BCrypt::Password.create(password)
    user = User.new(email: email, password_hash: password_hash)
    user.save!
    user
  end

  def self.email_is_present?(email)
    if User.find_by(email: email).nil?
      false
    else
      true
    end
  end

end