class ParticipateInsController < ApplicationController
  before_action :set_participate_in, only: [:show, :edit, :update, :destroy]

  # GET /participate_ins
  # GET /participate_ins.json
  def index
    @participate_ins = ParticipateIn.all
  end

  # GET /participate_ins/1
  # GET /participate_ins/1.json
  def show
  end

  # GET /participate_ins/new
  def new
    @participate_in = ParticipateIn.new
  end

  # GET /participate_ins/1/edit
  def edit
  end

  # POST /participate_ins
  # POST /participate_ins.json
  def create
    @participate_in = ParticipateIn.new(participate_in_params)
    respond_to do |format|
      if @participate_in.save
        format.html { redirect_to @participate_in, notice: 'Participate in was successfully created.' }
        format.json { render :show, status: :created, location: @participate_in }
      else
        format.html { render :new }
        format.json { render json: @participate_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participate_ins/1
  # PATCH/PUT /participate_ins/1.json
  def update
    respond_to do |format|
      if @participate_in.update(participate_in_params)
        format.html { redirect_to @participate_in, notice: 'Participate in was successfully updated.' }
        format.json { render :show, status: :ok, location: @participate_in }
      else
        format.html { render :edit }
        format.json { render json: @participate_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participate_ins/1
  # DELETE /participate_ins/1.json
  def destroy
    @participate_in.destroy
    respond_to do |format|
      format.html { redirect_to participate_ins_url, notice: 'Participate in was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participate_in
      @participate_in = ParticipateIn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participate_in_params
      params.require(:participate_in).permit(:user_id, :challenge_id, :continuous_check_in, :failed, :finished)
    end
end
