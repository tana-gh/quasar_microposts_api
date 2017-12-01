require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { build(:user) }
  
  it '正常系' do
    expect(user.save).to be_truthy
  end
  
  it 'nameの存在性チェック' do
    user.name = ''
    expect(user.valid?).to be_falsy
  end
  
  it 'nameの長さチェック' do
    user.name = 'a' * 60
    expect(user.valid?).to be_truthy
    
    user.name = 'a' * 61
    expect(user.valid?).to be_falsy
  end
  
  it 'nameの形式チェック' do
    user.name = '_123ABC-abc'
    expect(user.valid?).to be_truthy
    
    user.name = '@'
    expect(user.valid?).to be_falsy
  end
  
  it 'nameの一意性チェック' do
    dup_user = user.dup
    user.save
    expect(dup_user.valid?).to be_falsy
  end
  
  it 'passwordの存在性チェック' do
    user.password = '    '
    user.password_confirmation = '    '
    expect(user.valid?).to be_falsy
  end
  
  it 'passwordの長さチェック' do
    user.password = 'abcd'
    user.password_confirmation = 'abcd'
    expect(user.valid?).to be_truthy
    
    user.password = 'abc'
    user.password_confirmation = 'abc'
    expect(user.valid?).to be_falsy
  end
end
