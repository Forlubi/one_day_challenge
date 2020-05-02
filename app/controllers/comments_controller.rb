class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :find_challenge
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    # @comment = Comment.new(comment_params)

    @comment = @challenge.comments.create(comment_params)
    @comment.user_id = current_user.id

    # if @comment.save
    #   redirect_to challenge_path(@challenge)
    # else
    #   format.html { redirect_to challenge_path(@challenge), notice: 'Comment was successfully created.' }
    #   # render 'new'
    # end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to challenge_path(@challenge), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to challenge_path(@challenge) }
        # format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to challenge_path(@challenge), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { redirect_to challenge_path(@challenge) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to challenge_path(@challenge), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :challenge_id)
    end

    def find_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end

    def find_comment
      @comment = @challenge.comments.find(params[:id])
    end

    def comment_owner
      unless current_user.id == @comment.user_id
        flash[":notice"] = "Cannot manage others' comments."
        redirect_to @challenge
      end
    end
end
