class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  # GET /challenges
  # GET /challenges.json
  def index
    @challenges = Challenge.all
    # FIXME logged out user can see challenges, error when try to participate (Kuan-Yu)
  end

  def filter
    if params[:filter] == 'Life'
      challenges = Challenge.where(category: 'Life')
    elsif params[:filter] == 'Workout'
      challenges = Challenge.where(category: 'Workout')
    elsif params[:filter] == 'Habbit'
      challenges = Challenge.where(category: 'Habbit')
    elsif params[:filter] == 'Study'
      challenges = Challenge.where(category: 'Study')
    elsif params[:filter] == 'Philanthropy'
      challenges = Challenge.where(category: 'philanthropy')
    else
      challenges = Challenge.all
    end
    render 'challenges/filter_result', locals: {challenges: challenges, filter: params[:filter]}
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
    # FIXME Should not be able to reparticicate (hide btn) (Anyan)
    @comments = Comment.where(challenge_id: @challenge).order("created_at DESC")
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def challenge_params
    params.require(:challenge).permit(:name, :category, :description, :coins, :duration, :participant_number, :failed_number, :deadline, :image, :video)
  end
end
