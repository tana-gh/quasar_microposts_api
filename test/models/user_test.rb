require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "test", password: 'password', password_confirmation: 'password')
  end
  
  test '正常系' do
    assert @user.save
  end
  
  test 'nameの存在性チェック' do
    @user.name = ''
    assert_not @user.valid?
  end
  
  test 'nameの長さチェック' do
    @user.name = 'a' * 60
    assert @user.valid?
    
    @user.name = 'a' * 61
    assert_not @user.valid?
  end
  
  test 'nameの形式チェック' do
    @user.name = '_123ABC-abc'
    assert @user.valid?
    
    @user.name = '@'
    assert_not @user.valid?
  end
  
  test 'nameの一意性チェック' do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end
  
  test 'passwordの存在性チェック' do
    @user.password = '    '
    @user.password_confirmation = '    '
    assert_not @user.valid?
  end
  
  test 'passwordの長さチェック' do
    @user.password = 'abcd'
    @user.password_confirmation = 'abcd'
    assert @user.valid?
    
    @user.password = 'abc'
    @user.password_confirmation = 'abc'
    assert_not @user.valid?
  end
end
