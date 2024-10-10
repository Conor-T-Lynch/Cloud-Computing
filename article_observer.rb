# app/models/article_observer.rb
class ArticleObserver < ActiveRecord::Observer
    observe :article
  
    def after_create(article)
      # Actions to take after an article is created
      # For example, logging or notifying someone
      Rails.logger.info "New article created: #{article.title}"
    end
  end
  