class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :index]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    init_params = user_params
    # initialize other parameters, subject to change
    init_params[:coins] = 100
    init_params[:chechin_number] = 0
    init_params[:challenge_number] = 0
    
    @user = User.new(init_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to One Day Challenge!"
      redirect_to @user
      
    else
      if request.fullpath == "/"
        render "/#contact"
      else
        render 'new'
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def participate
    if participated?(current_user.id, params[:challenge_id])
    # if ParticipateIn.where(user_id: current_user.id, challenge_id: params[:challenge_id]).size >= 1
      flash[:warning] = "You're already in the challenge!"
    else
      ParticipateIn.create(user_id: current_user.id, challenge_id: params[:challenge_id])
      if favorited?(current_user.id, params[:challenge_id]) 
        Favorite.where(user_id: current_user.id, challenge_id: params[:challenge_id]).first.destroy   
      end
      flash[:success] = 'Challenge participated!'
    end
    redirect_to current_user
  end

  def drop
    ParticipateIn.where(user_id: current_user.id, challenge_id: params[:challenge_id]).first.destroy
    flash[:success] = 'Challenge successfully dropped!'
    redirect_to current_user
  end


  def favorite
    if participated?(current_user.id, params[:challenge_id])
      flash[:warning] = "You're already in the challenge!"
    elsif favorited?(current_user.id, params[:challenge_id]) 
      flash[:warning] = "You've already favorited challenge!"
    else
      Favorite.create(user_id: current_user.id, challenge_id: params[:challenge_id])
      flash[:success] = 'Challenge favorited!'
    end
    redirect_to current_user
  end

  def unfavorite
    Favorite.where(user_id: current_user.id, challenge_id: params[:challenge_id]).first.destroy
    flash[:success] = 'Challenge successfully unfavorited!'
    redirect_to current_user
  end

  def checkin
  
  end

  def test
    @user = User.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "Please don't mess with others' profiles!"
        # redirect_to root_url
        redirect_to @user
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :coins, :chechin_number, :challenge_number)
    end
    
    
    # def user_params
    #   params.require(:user).permit(:name, :email, :password,
    #                                :password_confirmation)
    # end
end
