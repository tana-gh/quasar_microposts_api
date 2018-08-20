require 'rails_helper'

RSpec.describe Follow, type: :model do
  
  let(:follow) { build :follow }

  it '正常系' do
    expect(follow.save).to be_truthy
  end

  it 'followeeの存在性チェック' do
    follow.followee = nil
    expect(follow.save).to be_falsy
  end

  it 'followerの存在性チェック' do
    follow.follower = nil
    expect(follow.save).to be_falsy
  end

end
