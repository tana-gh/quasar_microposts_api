require 'rails_helper'
require 'json'

RSpec.describe ApiController, type: :controller do
  
  render_views
  
  before do
    create :user
    create_list :microposts, 10
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
  
  it 'サインアップのテスト' do
    get :signup, xhr: true, params: signup_params
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_empty
    
    expect(cookies[:user_id]).to eq("2")
  end
  
  it 'サインアップ失敗のテスト' do
    get :signup, xhr: true, params: signup_failure_params
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to_not be_empty
    
    expect(cookies[:user_id]).to be_nil
  end
  
  it 'ログインのテスト' do
    get :login, xhr: true, params: login_params
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_empty
    
    expect(cookies[:user_id]).to eq("1")
  end
  
  it 'ログアウトのテスト' do
    get :logout, xhr: true, params: {}
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to_not be_empty
    
    expect(cookies[:user_id]).to be_nil
  end
  
  it 'ログインログアウトのテスト' do
    get :login, xhr: true, params: login_params
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_empty
    
    expect(cookies[:user_id]).to eq("1")
    
    get :logout, xhr: true, params: {}
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_empty
    
    expect(cookies[:user_id]).to be_nil
  end
  
  it 'is_loginのテスト' do
    get :is_login, xhr: true, params: {}
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to_not be_empty
  end
  
  it 'ログイン後is_loginのテスト' do
    get :login, xhr: true, params: login_params
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_empty
    
    expect(cookies[:user_id]).to eq("1")
    
    get :is_login, xhr: true, params: {}
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_empty
  end
  
  it 'get_messagesのテスト' do
    cookies[:user_id] = 1
    
    get :get_messages, xhr: true, params: {}
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
    expect(body['messages'].length).to be(10)
  end
  
  it 'get_messages失敗のテスト' do
    cookies[:user_id] = nil
    
    get :get_messages, xhr: true, params: {}
    expect(response).to be_success
    
    body = JSON.parse(response.body)
    expect(body['status']).to be_falsy
    expect(body['messages'].length).to be(0)
  end
end
