require 'rails_helper'

RSpec.describe UserApiController, type: :controller do
  
  render_views
  
  before do
    create :user
  end
  
  let(:signup_params) do
    { 'user_name' => 'signup',
      'password'  => 'password',
      'password_confirmation' => 'password'}
  end
  
  let(:signup_failure_params) do
    { 'user_name' => '',
      'password'  => 'password',
      'password_confirmation' => 'pazzword' }
  end
  
  let(:login_params) do
    { 'user_name' => 'test', 'password' => 'password' }
  end
  
  def post_and_validate_response(api, params, status, message, cookie_user_id)
    post api, xhr: true, params: params
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    switch_expect body['status'],    status
    switch_expect body['message'],   message
    switch_expect cookies[:user_id], cookie_user_id
  end
  
  def switch_expect(target, hash)
    if hash.has_key?(:to)
      expect(target).to hash[:to]
    elsif hash.has_key?(:to_not)
      expect(target).to_not hash[:to_not]
    end
  end
  
  it 'サインアップのテスト' do
    post_and_validate_response :signup,
                               signup_params,
                               { to: be_truthy },
                               { to: be_empty },
                               { to: eq(2) }
  end
  
  it 'サインアップ失敗のテスト' do
    post_and_validate_response :signup,
                               signup_failure_params,
                               { to:     be_falsy },
                               { to_not: be_empty },
                               { to:     be_nil }
  end
  
  it 'ログインのテスト' do
    post_and_validate_response :login,
                               login_params,
                               { to: be_truthy },
                               { to: be_empty },
                               { to: eq(1) }
  end
  
  it 'ログアウトのテスト' do
    post_and_validate_response :logout,
                               {},
                               { to:     be_falsy },
                               { to_not: be_empty },
                               { to:     be_nil }
  end
  
  it 'ログインログアウトのテスト' do
    post_and_validate_response :login,
                               login_params,
                               { to: be_truthy },
                               { to: be_empty },
                               { to: eq(1) }
                               
    post_and_validate_response :logout,
                               {},
                               { to: be_truthy },
                               { to: be_empty },
                               { to: be_nil }
  end
  
  it 'is_loginのテスト' do
    post_and_validate_response :is_login,
                               {},
                               { to:     be_falsy },
                               { to_not: be_empty },
                               {}
  end
  
  it 'ログイン後is_loginのテスト' do
    post_and_validate_response :login,
                               login_params,
                               { to: be_truthy },
                               { to: be_empty },
                               { to: eq(1) }
    
    post_and_validate_response :is_login,
                               {},
                               { to: be_truthy },
                               { to: be_empty },
                               {}
  end
end
