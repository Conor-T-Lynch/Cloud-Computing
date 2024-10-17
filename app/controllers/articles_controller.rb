class ArticlesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in for all actions except index and show
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authorize_article, only: %i[edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :article_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /articles or /articles.json
  def index
    if params[:title].present?
      @articles = ArticleSearch.search(params[:title])
    else
      @articles = Article.all
    end
    authorize Article
  end  

  # GET /articles/search
  def search
    if params[:title].present?
      @article = ArticleSearch.search(params[:title]).first
      
      if @article
        # Redirect to the "Show Article" page if a match is found
        redirect_to @article
      else
        # If no article is found, redirect back with an error message
        flash[:alert] = "Article not found"
        redirect_to articles_path
      end
    else
      # If no search term is provided, redirect to the articles index
      redirect_to articles_path
    end
  end

  # GET /articles/search_results
  def search_results
    if params[:title].present?
      @articles = ArticleSearch.search(params[:title])
    else
      @articles = []  # No articles if no search term is provided
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    authorize @article  # Ensure users can view this specific article
  end

  # GET /articles/new
  def new
    @article = Article.new
    authorize @article  # Ensure users can create new articles
  end

  # GET /articles/1/edit
  def edit
    # No need for additional authorization here since it's handled in before_action
  end

  # POST /articles or /articles.json
  def create
    @article = current_user.articles.build(article_params)  # Associate the current user with the article
    authorize @article  # Ensure users can create new articles

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
        format.turbo_stream  # Add this for Turbolinks support if necessary
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    authorize @article  # Ensure users can update their articles

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
        format.turbo_stream  # Add this for Turbolinks support if necessary
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    authorize @article  # Ensure users can destroy their articles
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_path, notice: "Article was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
      format.turbo_stream  # Add this for Turbolinks support if necessary
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Ensure users can only modify their own articles
  def authorize_article
    authorize @article
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body)
  end

  # Handle record not found
  def article_not_found
    respond_to do |format|
      format.html { redirect_to articles_path, notice: "Article not found.", status: :not_found }
      format.json { render json: { error: "Article not found" }, status: :not_found }
    end
  end

  # Handle unauthorized access
  def user_not_authorized
    respond_to do |format|
      format.html { redirect_to articles_path, notice: "You are not authorized to perform this action.", status: :forbidden }
      format.json { render json: { error: "Not authorized" }, status: :forbidden }
    end
  end
end
