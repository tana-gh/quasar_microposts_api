require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApiHelper. For example:
#
# describe ApiHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApiHelper, type: :helper do
  
  it 'update_render_messageのテスト' do
    update_render_message(false, 'test')
    expect(@status) .to be_falsy
    expect(@message).to eq('test')
  end
  
  it 'update_render_messagesのテスト' do
    update_render_messages(false, ['test1', 'test2'])
    expect(@status).to be_falsy
    expect(@messages.count).to eq(2)
    expect(@messages[0]).to    eq('test1')
  end
end
