class UsersController < ApplicationController

  before_action :authorize_request, except: %i[create login]

  def create
    @user = User.new(username: params[:username], password: params[:password])
    @user.role="ROLE_USER"
    if @user.save
      render json: @user
    else
      render json: { error: { status: "400",
                               title: "Bad request",
                               details: @user.errors
                             }
      }, status: :bad_request
    end
  end

  def login
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      @token = JsonWebToken.encode(user_id: @user.id)
      render json: {
          token: @token,
          username: @user.username,
          role: @user.role
      }, status: :ok
    else
      render json: { error: 'Wrong username or password' }, status: :bad_request
    end
  end

  def show
    authorize @current_user
    @user = User.find_by_id(params[:id])
    if !@user.nil?
      @user.password = nil
      render json: @user
    else
      render json: { errors:[{ status: "404",
                               title: "Not found"
                             }]
      }, status: 404
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.nil?
      return render json: { errors:[{ status: "404",
                               title: "Not found"
                             }]
      }, status: :not_found
    end
    authorize @user
    if @user.update(username: params[:username], password: params[:password])
      render json: @user
    else
      render json: { error: @user.errors }
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if @user.nil?
      return render json: { errors: { status: "404",
                                      title: "Not found"
                                    }
      }, status: :not_found
    end
    authorize @user
    if @user.destroy
      render json: { success: true }
    else
      render json: { error: @user.errors }
    end
  end

end
