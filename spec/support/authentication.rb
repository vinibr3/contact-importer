module Authentication
  def self.with_user(user = FactoryBot.create(:user), request)
    request.session[:user_id] = user.id
  end
end
