class Api::V1::LearningSessionsController < ApplicationController
  before_action :authenticate_user!
  #load_and_authorize_resource


  def index
    @learning_sessions = LearningSession.accessible_by(current_ability, :index)
    render json: @learning_sessions, status: :ok
  end

  def show_accessible
    @learning_sessions = LearningSession.accessible_by(current_ability, :show_accessible)
    if !search_learning_session_param.empty?
      @learning_sessions = SearchLearningSessions.call(@learning_sessions, search_learning_session_param)
    end
    render json: @learning_sessions, status: :ok
  end

  def show_specific
    if !search_learning_session_param.values_at("flashcard_set_id", "user_id").join.empty?
      @learning_sessions = LearningSession.accessible_by(current_ability, :show_specific)
      @learning_sessions = SearchLearningSessions.call(@learning_sessions, search_learning_session_param)
      render json: @learning_sessions, status: :ok
    else
    render json: { message: "Provide at least one valid parameter"}, status: :unprocessable_entity
    end
  end

  def create
    if learning_session_param.values_at("flashcard_set_id").join.empty?
      render status: :unprocessable_entity
      return
    end
    @learning_session = FlashcardSet.find(learning_session_param[:flashcard_set_id]).learning_sessions.new
    @learning_session.user = current_user

    if @learning_session.save
      render json: @learning_session, status: :ok
    else
      render json: @learning_session.errors, status: :unprocessable_entity
    end
  end

  private

    def learning_session_param
      params.require(:learning_session).permit(:flashcard_set_id)
    end

    def search_learning_session_param
      params.fetch(:learning_session, {}).permit(:flashcard_set_id, :user_id)
    end

end
