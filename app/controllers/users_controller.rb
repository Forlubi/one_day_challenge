class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user == @user
      @owned_challenges = Challenge.where(owner_id: current_user.id)
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { sign_in_and_redirect @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
        
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User deleted.'
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

    # Only allow a list of trusted parameters through.
    # def user_params
    #   params.require(:user).permit(:name, :coins)
    # end
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
      params.require(:user).permit(:name, :email, :password, :coins, :chechin_number, :challenge_number, :avatar)
    end
    
    def participated?(user_id, challenge_id)
      return ParticipateIn.where(user_id: user_id, challenge_id: challenge_id).size >= 1
    end

    def favorited?(user_id, challenge_id)
      return Favorite.where(user_id: user_id, challenge_id: challenge_id).size >= 1
    end

    def checkedIn?(user_id, challenge_id)
      return ParticipateIn.where(user_id: user_id, challenge_id: challenge_id).first.updated_at == Date.today
    end
end