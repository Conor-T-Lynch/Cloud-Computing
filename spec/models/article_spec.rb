require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'is valid with valid attributes' do
    article = Article.new(title: 'Test Title', content: 'Test Content')
    expect(article).to be_valid
  end

  it 'is not valid without a title' do
    article = Article.new(title: nil)
    expect(article).to_not be_valid
  end
end
