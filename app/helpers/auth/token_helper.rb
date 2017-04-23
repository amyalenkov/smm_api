class TokenHelper

  def self.create_token(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    user_password = BCrypt::Password.new(user.password_hash)
    if user_password == password
      token = ApiKey.create!(user_id: user.id)
      token.access_token
    else
      return nil
    end
  end

  def self.delete_token(token)
    token_row = ApiKey.find_by(access_token: token)
    token_row.destroy
  end

end