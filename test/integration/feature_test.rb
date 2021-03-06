require "test_helper"

describe "Feature Integration" do
  before do
    clear_emails

    visit root_path
    fill_in "email", with: "test@email.com"
    click_on "Send email"

    open_email("test@email.com") # sets current_email
  end

  it "logs in a user when provided an email" do
    current_email.first(:link).click
    page.must_have_content "success"
  end

  it "only works once" do
    current_email.first(:link).click
    current_email.first(:link).click
    page.must_have_content "failed"
  end
end
