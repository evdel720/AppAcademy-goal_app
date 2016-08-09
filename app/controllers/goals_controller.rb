class GoalsController < ApplicationController
  before_filter :require_user
  before_filter :is_owner?, only: [:edit, :update, :destroy]

  def index
    @goals = Goal.where(goal_private: false)
    @goals += Goal.where(user: current_user, goal_private: true)
  end

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

  def edit
    @goal = Goal.find(params[:id])

  end

  def update

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.destroy
    redirect_to goals_url
  end


  def goal_params
    params.require(:goal).permit(:title, :details, :goal_private, :completed)
  end

  def is_owner?
    @goal = Goal.find_by(id: params[:id])
    # fail
    redirect_to goals_url if @goal.user_id != current_user.id
  end
end
