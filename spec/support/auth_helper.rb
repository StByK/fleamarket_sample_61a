module AuthHelper
  def basic_login
    @request.env ||= {}
    user = 'arekore'
    pw = 'passarekore'
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end