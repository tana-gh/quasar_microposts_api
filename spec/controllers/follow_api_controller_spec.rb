require 'rails_helper'

RSpec.describe FollowApiController, type: :controller do

  render_views
  
  before do
    create      :user_session
    create_list :users  , 10
    create_list :follows, 10
  end

  it 'get_followeesのテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :get_followees, xhr: true, params: {}
    expect(response.status).to eq(200)

    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
    expect(body['users'].length).to eq(0)
  end

  it 'get_followersのテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :get_followers, xhr: true, params: {}
    expect(response.status).to eq(200)

    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
    expect(body['users'].length).to eq(10)
  end

  it 'followのテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :follow, xhr: true, params: { user: User.all[1].name }
    expect(response.status).to eq(200)

    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
  end

  it 'follow失敗のテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :follow, xhr: true, params: { user: User.all[1].name }
    expect(response.status).to eq(200)
    post :follow, xhr: true, params: { user: User.all[1].name }
    expect(response.status).to eq(401)

    body = JSON.parse(response.body)
    expect(body['status']).to be_falsy
  end

  it 'unfollowのテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :follow  , xhr: true, params: { user: User.all[1].name }
    expect(response.status).to eq(200)
    post :unfollow, xhr: true, params: { user: User.all[1].name }
    expect(response.status).to eq(200)

    body = JSON.parse(response.body)
    expect(body['status']).to be_truthy
  end

  it 'unfollow失敗のテスト' do
    request.headers['Authorization'] = "Token #{UserSession.first.token}"
    post :unfollow, xhr: true, params: { user: User.all[1].name }
    expect(response.status).to eq(401)

    body = JSON.parse(response.body)
    expect(body['status']).to be_falsy
  end

end
