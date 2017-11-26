require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    user = User.new(name: 'test', password: 'password', password_confirmation: 'password')
    user.save
    @mp = Micropost.new(message: 'test', user: user)
  end
  
  test '正常系' do
    assert @mp.save
  end
  
  test 'messageの存在性チェック' do
    @mp.message = ''
    assert_not @mp.valid?
  end
  
  test 'messageの長さチェック' do
    @mp.message = 'a' * 140
    assert @mp.valid?
    
    @mp.message = 'a' * 141
    assert_not @mp.valid?
  end
  
  test 'userの存在性チェック' do
    @mp.user = nil
    assert_not @mp.valid?
  end
end
