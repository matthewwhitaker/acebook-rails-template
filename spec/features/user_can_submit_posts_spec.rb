require 'rails_helper'
require 'simple_send_keys'

RSpec.feature "Timeline", type: :feature, js: true do
  scenario "Can submit posts and view them" do
    user_sign_up
    create_new_post("Hello world!")
    expect(page).to have_content("Hello world!")
  end

  scenario "Can see the newest post first" do
    user_sign_up
    create_new_post("Hello World")
    create_new_post("Good morning")
    expect(page_content).to have_content("Good morning")
  end

  scenario "Can see the post with date and time" do
    post = Post.create(message: "Hello")
    time = post[:created_at].strftime("%B %d %Y, %l:%M%P")
    user_sign_up
    expect(page_content).to have_content("#{time}")
  end

  scenario "Can submit a multi-line post and view it" do
    user_sign_up
    click_link "New post"
    find_field('post_message').send_keys('[This, enter, is, enter, a, enter, multi-line, enter, post]')
    click_button "Submit"
    expect(page.html).to include("This\n<br>is\n<br>a\n<br>multi-line\n<br>post")
  end

  scenario "redirect to sign in page when not logged in" do
    visit "/posts"
    expect(page.current_path).to eq '/users/sign_in'
  end

  scenario  "user can sign up" do
    visit "/posts"
    expect(page.current_path).to eq '/users/sign_in'
    click_link('Sign up')
    fill_in('user_email', :with => 'test@test.com')
    fill_in('user_password', :with => 'testing123')
    fill_in('user_password_confirmation', :with => 'testing123')
    click_button 'Sign up'
    expect(page.current_path).to eq '/posts'
  end
end
