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
  
  it 'user_idの存在性チェック' do
    us.user = nil
    expect(us.valid?).to be_falsy
  end
end
