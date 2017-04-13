class TokenHelper

  def self.create_token(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    if password == BCrypt::Password.new(user.password_hash)
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

  def self.check_auth(token_header)
    error!(400) if token_header.nil?
    token = ApiKey.find_by(access_token: token_header)
    error!(400) if token.nil?
    error!(400) if token.expired?
  end
end