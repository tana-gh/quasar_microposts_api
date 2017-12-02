require 'rails_helper'
require 'json'

RSpec.describe ApiController, type: :controller do
  
  render_views
  
  let(:user) { create(:user) }
  
  it 'ログインのテスト' do
    post :login, xhr: true,
         body: { 'user_name' => 'test', 'password' => 'password' }.to_json
    response.should be_success
    
    body = JSON.parse(response.body)
    expect(body['status']) .to be_truthy
    expect(body['message']).to be_empty
  end
end
