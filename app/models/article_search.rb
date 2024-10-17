# app/models/article_search.rb
module ArticleSearch
    def self.search(title)
      Article.where('title LIKE ?', "%#{title}%")
    end
  end
  