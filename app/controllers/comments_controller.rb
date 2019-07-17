class CommentsController < ApplicationController

  before_action :authorize_request

  # get all posts comments
  def index
    @post = Post.find_by_id(params[:post_id])
    if @post.nil?
      return render json: { error: "Post not found" }, status: :not_found
    end
    render json: @post.comments,status: 200
  end

  # post a comment ot a post
  def create
    # get the post
    @post = Post.find_by_id(params[:post_id])
    if @post.nil?
      return render json: { error: "Post not found" }, status: :not_found
    end
    # create post to comment
    @comment = @post.comments.create(body: params[:body])
    # associate comment before save(comment cannot be saved without user_id)
    @comment.user = @current_user
    # save comment
    if @comment.save
      render json: @comment, status: :ok
    else
      render json: { errors: { status: "400",
                               title: "Bad request",
                               details: @comment.errors
                              }
      }, status: :bad_request
    end
  end

  # destroy a comment
  def destroy
    @comment = Comment.find_by_id(params[:id])
    if @comment.nil?
      return render json: { error: "Comment not found"}, status: :not_found
    end
    authorize @comment
    if @comment.destroy
      render json: { success: true }, status: :ok
    else
      render json: { errors: { status: "400",
                               title: "Bad request",
                               details: @comment.errors
                              }
      }, status: :bad_request
    end
  end

  # get specific comment
  def show
    @comment = Comment.find_by_id(params[:id])
    if @comment.nil?
      render json: { error: "Comment not found" }, status: :not_found
    else
      render json: @comment, status: :ok
    end
  end

  # update comment
  def update
    @comment = Comment.find_by_id(params[:id])
    if @comment.nil?
      return render json: { error: "Comment not found" }, status: :not_found
    end
    authorize @comment
    @updated_comment = @comment.update(body: params[:body])
    render json: @updated_comment, status: :ok
  end

end
