class QuestionsController < ApplicationController

  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @questions = Question.paginate(page: params[:page], per_page: 10)
  end

  def show
  	 @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.build(question_params)
	 
	 if @question.save
		flash[:suceess] = "New question posted"
	 else
	 	flash[:error] = "Unexpected Error!"
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
	 redirect_to root_url
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content)
    end

	 def correct_user
		@question = current_user.questions.find_by(id: params[:id])
		redirect_to root_url if @question.nil?
	 end

	 def admin_user
	 	redirect_to(root_path) unless current_user.admin?
	 end

end
