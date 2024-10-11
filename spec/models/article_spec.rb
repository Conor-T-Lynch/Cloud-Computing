require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  it "is valid with valid attributes" do
    article = Article.new(title: 'Test Title', body: 'Test Content', user_id: user.id)
    expect(article).to be_valid
  end

  it "is not valid without a title" do
    article = Article.new(title: nil, body: 'Test Content', user_id: user.id)
    expect(article).to_not be_valid
  end

  it "is not valid without a body" do
    article = Article.new(title: 'Test Title', body: nil, user_id: user.id)
    expect(article).to_not be_valid
  end

  it "is not valid without a user" do
    article = Article.new(title: 'Test Title', body: 'Test Content', user_id: nil)
    expect(article).to_not be_valid
  end
end
