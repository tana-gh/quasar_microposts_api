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
  
  let(:login_failure_params) do
    { 'user_name' => '', 'password' => 'password' }
  end
  
  it 'サインアップのテスト' do
    post :signup, xhr: true, params: signup_params
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
    expect(body['token']) .to eq(User.find_by(name: 'signup').user_session.token)
  end
  
  it 'サインアップ失敗のテスト' do
    post :signup, xhr: true, params: signup_failure_params
    expect(response.status).to eq(401)
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to be_present
  end
  
  it 'ログインのテスト' do
    post :login, xhr: true, params: login_params
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
    expect(body['token']) .to eq(User.find_by(name: 'test').user_session.token)
  end
  
  it 'ログイン失敗のテスト' do
    post :login, xhr: true, params: login_failure_params
    expect(response.status).to eq(401)
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to be_present
  end
  
  it 'ログアウトのテスト' do
    post :logout, xhr: true, params: {}
    expect(response.status).to eq(401)
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to be_present
  end
  
  it 'ログインログアウトのテスト' do
    post :login, xhr: true, params: login_params
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    token = User.find_by(name: 'test').user_session.token
    expect(body['token']).to eq(token)
    
    request.headers['Authorization'] = "Token #{token}"
    post :logout, xhr: true,  params: {}
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_present
  end
  
  it 'is_loginのテスト' do
    post :is_login, xhr: true, params: {}
    expect(response.status).to eq(401)
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to be_present
  end
  
  it 'ログイン後is_loginのテスト' do
    post :login, xhr: true, params: login_params
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    token = User.find_by(name: 'test').user_session.token
    expect(body['token']).to eq(token)
    
    request.headers['Authorization'] = "Token #{token}"
    post :is_login, xhr: true, params: {}
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_present
  end
  
  it 'ログインログアウト後is_loginのテスト' do
    post :login, xhr: true, params: login_params
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    token = User.find_by(name: 'test').user_session.token
    expect(body['token']).to eq(token)
    
    request.headers['Authorization'] = "Token #{token}"
    post :logout, xhr: true,  params: {}
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['message']).to be_present
    
    request.headers['Authorization'] = "Token #{token}"
    post :is_login, xhr: true, params: {}
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to be_present
  end
end
