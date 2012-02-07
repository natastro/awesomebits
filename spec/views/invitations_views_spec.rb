require 'spec_helper'

describe 'invitations/new.html.erb' do

  let!(:role) { FactoryGirl.create(:role, :name => 'dean') }
  let!(:user) { role.user }
  let!(:chapter) { role.chapter }
  let!(:another_role) { FactoryGirl.create(:role, :name => 'dean', :user => user) }
  let!(:another_chapter) { another_role.chapter }
  let!(:invitation) { Invitation.new }

  it 'renders a chapter drop down when dean of multiple chapters' do
    assign(:chapter, chapter)
    assign(:invitation, invitation)
    view.stubs(:current_user).returns(user)
    view.stubs(:chapters_dropdown?).returns(true)
    view.stubs(:chapters_collection).returns([chapter, another_chapter])
    render
    rendered.should have_content("Select a chapter")
  end

  it 'renders a chapter hidden field when dean of one chapter' do
    assign(:chapter, chapter)
    assign(:invitation, invitation)
    view.stubs(:current_user).returns(user)
    view.stubs(:chapters_dropdown?).returns(false)
    view.stubs(:chapter).returns(chapter)
    render
    rendered.should_not have_content("Select a chapter")
  end

end