class TasksController < ApplicationController
  
  before_action :set_user
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    @tasks = @user.tasks.order(id: "DESC")
  end
  
  def show
    @task = @user.tasks.find(params[:id])
  end
  
  def new
    @task = Task.new #form_withのmodel指定で必要 model: @taskによってparams[:task][:name],params[:task][:description]になる
  end
  
  def create
    @task = @user.tasks.build(params_task) #@taskにset_userで定義した@userのuser_idをtaskテーブルと結び付けてStronParameterで取得したデータを入れている
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user #indewページへリダイレクト
    else
      render :new
    end
  end
  
  def edit
    @task = @user.tasks.find(params[:id])
  end
  
  def update
    @task = @user.tasks.find(params[:id]) #更新するタスクオブジェクトを@taskに代入
    if @task.update_attributes(params_task) #StrongParameterの値を受け取り更新
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user,@task) #変更したタスク詳細ページへリダイレクト
    else
      render :edit
    end
  end
  
  def destroy
    @task = @user.tasks.find_by(id: params[:id])
    @task.destroy
    flash[:success] = "#{@task.name}のデータを削除しました。"
    redirect_to user_tasks_url(@user)
  end
  
  private
    
    def set_user #タスクに関するページでは全てどのユーザーのタスクかを判定するのにUserのデーターが不可欠
      @user = User.find(params[:user_id])
    end
    
    def params_task
      params.require(:task).permit( :name, :description)
    end
    
    
   
    
  


end
