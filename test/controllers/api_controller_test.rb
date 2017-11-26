require 'test_helper'
require 'json'

class ApiControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    User.new(name: 'test', password: 'password', password_confirmation: 'password').save
  end
  
  test 'ログインのテスト' do
    json = { user_name: 'test', password: 'password' }.to_json
    post login_path, params: { body: json }
    assert_response :success
    
    body = JSON.parse(@response.body)
    assert       body['status']
    assert_equal body['message'], ''
  end
end
