require 'rails_helper'

RSpec.describe UserSession, type: :model do
  
  let(:us) { build :user_session }
  
  it '正常系' do
    expect(us.save).to be_truthy
  end
  
  it 'tokenの存在性チェック' do
    us.token = ''
    expect(us.valid?).to be_falsy
  end
  
  it 'tokenの一意性チェック' do
    dup_us = us.dup
    us.save
    expect(dup_us.valid?).to be_falsy
  end
  
  it 'expiresの存在性チェック' do
    us.expires = nil
    expect(us.valid?).to be_falsy
  end
  
  it 'user_idの存在性チェック' do
    us.user = nil
    expect(us.valid?).to be_falsy
  end
  
  it 'set_new_tokenのテスト' do
    dt = DateTime.new(2000, 1, 1, 0, 0, 0)
    Timecop.freeze(dt) do
      us.set_new_token
    end
    expect(us.token)  .to     be_present
    expect(us.token)  .to_not eq('token')
    expect(us.expires).to     eq(dt + UserSession::EXPIRES_OFFSET)
  end
  
  it 'is_in_expiresのテスト' do
    dt = DateTime.new(2000, 1, 1, 0, 0, 0)
    us.expires = dt
    Timecop.freeze(dt + UserSession::EXPIRES_OFFSET + 1) do
      expect(us.is_in_expires).to be_falsy
    end
  end
end
