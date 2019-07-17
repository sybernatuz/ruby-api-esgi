class PostsController < ApplicationController

  before_action :authorize_request
  require_relative "../../app/services/crawler/crawler_factory"

  #Get all posts
  def index
    @posts = find_posts(params)
    render json: @posts.to_json(:include =>
                                    {
                                        :user => {
                                              :only => [:id, :username]
                                        }
                                    }), status: :ok
  end

  # Get post by id
  def show
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      render json: { error: "Not found" }, status: :not_found
    else
      render json: @post.to_json(:include =>
                                      {
                                          :user => {
                                              :only => [:id, :username]
                                          },
                                          :comments => {
                                              :include => {
                                                  :user => {
                                                      :only => [:id, :username]
                                                  },
                                              }
                                          }
                                      }), status: :ok
    end
  end

  # create a post
  def create
    @post = @current_user.posts.create(title: params[:title], text: params[:text], picture: params[:picture], link: params[:link], category: params[:category])
    if @post.link == ""
      @post.link = nil
    end
    unless @post.link.nil?
      @post = CrawlerFactory.crawl(@post.link)
      @post.user = @current_user
    end

    if @post.save
      render json: @post, status: :ok
    else
      render json: { errors: { status: "400",
                               title: "Bad request",
                               details: @post.errors
                              }
      }, status: :bad_request
    end
  end

  #  update an article
  def update
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      return render json: { error: "Not found" }, status: :not_found
    end
    authorize @post
    @updated_post = @post.update(title: params[:title], text: params[:text])
    render json: @updated_post, status: :ok
  end

  # Delete an article
  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      return render json: { data: "null" }, status: 404
    end
      authorize @post
    if @post.destroy
      render json: { success: true }
    else
      render json: { error: @post.errors }
    end
  end

  private

  def find_posts(params)
    @user = User.find_by_username(params[:username])
    if params[:category].nil?
      @posts = Post.where(user: @user).order('created_at DESC')
    else
      @posts = Post.where({user: @user, category: params[:category]}).order('created_at DESC')
    end
  end


end

