class PostsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :authenticate_request

  def index
    @post = Post.all
    render json:{data:{ type: 'post', attributes:{ data:@post }}},status: 200
  end

  def create
    @user = User.new(user_params[:attributes])
    if @user.save
      render json:@user, status: 201
    else
      render json: { errors:[{ status: "400",
                               title: "Bad request",
                               detail:@user.errors
                             }]
      }, status: 400
    end
  end

  private
  def user_params
    params.require(:data).permit(:type ,attributes:[:username, :password, :full_name])
  end
end

