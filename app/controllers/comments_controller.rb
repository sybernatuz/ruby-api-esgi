class CommentsController < ApplicationController

  # get all posts comments
  def index
    @post = Post.find_by_id(params[:post_id])
    render json:{data:{ type: 'comment', attributes:{ data:@post.comments }}},status: 200
  end

  # post a comment ot a post
  def create
    # get the post
    @post = Post.find_by_id(params[:post_id])
    # create post to comment
    @post_comment = @post.comments.create(comment_params[:attributes])
    # associate comment before save(comment cannot be saved without user_id)
    @post_comment.user_id = @current_user.id
    # save comment
    @post_comment.save
    render json: response_params(@post.comments.last), status: 201
  end

  # destroy a comment
  def destroy
    @comment = Comment.find_by_id(params[:id])
    @post_owner_id = (Post.find_by_id(@comment.post_id)).user_id
    if @comment.nil?
      render json: { data: "null"},status: 404
    elsif @comment.user_id == @current_user.id || @post_owner_id == @current_user.id
      @comment.destroy
      render json: response_params("deleted"), status: 204
    else
      render json: response_params({error: "can only delete own comment or comment on your own post"}), status: 401
    end
  end

  # get specific comment
  def show
    @comment = Comment.find_by_id(params[:id])
    if @comment.nil?
      render json: { data: "null" }, status: 404
    else
      render json: response_params(@comment), status: 200
    end
  end

  # update comment
  def update
    @comment = Comment.find_by_id(params[:id])
    if @comment.nil?
      render json:{ data: "null"}, status: 404
    elsif @current_user.id == @comment.user_id
      @updated_comment = @comment.update(comment_params[:attributes])
      render json:(response_params(@updated_comment)), status: 200
    else
      render json:response_params({error: "can only delete own comment or comment on your own post"}), status: 401
    end
  end

  private

  def comment_params
    params.require(:data).permit(:type ,attributes:[:body, :post_id, :user_id])
  end

  def response_params(comment_attributes)
    { data: { type: 'comment',attributes: comment_attributes } }
  end

end
