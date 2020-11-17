class TasksController < ApplicationController
  
  before_action :set_user
  
  def index
    @tasks = Task.where(user_id: params[:user_id])
  end
  
  def show
  end
  
  def new
  end
  
  def create
    @task = @user.tasks.new(params_task)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
  end
  
  private
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def params_task
      params.permit(:name, :description)
    end
    
    
end
