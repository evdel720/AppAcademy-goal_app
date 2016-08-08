class GoalsController < ApplicationController
  before_filter :require_user
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find_by(id: params[:id])
  end





  def goal_params
    params.require(:goal).permit(:title, :details, :goal_private, :completed)
  end
end
