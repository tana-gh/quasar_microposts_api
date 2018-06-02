require 'rails_helper'
require 'json'

RSpec.describe ApiController, type: :controller do
  
  render_views
  
  before do
    create      :user_session
    create_list :users     , 10
    create_list :microposts, 10
  end
  
  it 'get_usersのテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :get_users, xhr: true, params: {}
    expect(response.status).to eq(200)

    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
    expect(body['users'].length).to eq(11)
  end

  it 'get_micropostsのテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :get_microposts, xhr: true, params: { index: 2, count: 5 }
    expect(response.status).to eq(200)
    
    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
    expect(body['microposts'].length).to eq(5)
  end
  
  it 'post_micropostのテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :post_micropost, xhr: true, params: { micropost: 'test' }
    expect(response.status).to eq(200)
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_present
    expect(Micropost.all[10].message).to eq('test')
  end
  
  it 'post_micropost失敗のテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :post_micropost, xhr: true, params: { micropost: '' }
    expect(response.status).to eq(400)
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_falsy
    expect(body['message']).to be_present
  end
end
