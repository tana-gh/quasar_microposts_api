require 'rails_helper'
require 'json'

RSpec.describe ApiController, type: :controller do
  
  render_views
  
  before do
    create :user
    create_list :microposts, 10
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
