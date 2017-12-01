require 'rails_helper'

RSpec.describe Micropost, type: :model do
  
  let(:mp) { build :micropost }
  
  it '正常系' do
    expect(mp.save).to be_truthy
  end
  
  it 'messageの存在性チェック' do
    mp.message = ''
    expect(mp.valid?).to be_falsy
  end
  
  it 'messageの長さチェック' do
    mp.message = 'a' * 140
    expect(mp.valid?).to be_truthy
    
    mp.message = 'a' * 141
    expect(mp.valid?).to be_falsy
  end
  
  it 'userの存在性チェック' do
    mp.user = nil
    expect(mp.valid?).to be_falsy
  end
end
