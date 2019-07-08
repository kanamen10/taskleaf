class TasksController < ApplicationController
  def index
    # @tasks = Task.all
    # taskのuser_idとuserのidを紐づけたので下記に変更
    # @tasks = current_user.tasks でもよい
    @tasks = Task.where(user_id: current_user.id)
  end

  def show
    @task = current_user.tasks.find(params[:id])
    # @task = Task.where(params[:id], user_id: current_user.id)
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "Task #{task.name}を更新しました！"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "Task #{task.name}を削除しました！"
  end

  def create
    # @task = Task.new(task_params)
    # taskのuser_idとuserのidを紐づけたので下記に変更
    @task = Task.new(task_params.merge(user_id: current_user.id))
    if @task.save
      redirect_to tasks_url, notice: "タスク #{@task.name} を登録しました。"
    else
      render :new
      # redirect_to new_task_path, notice: '入力項目に誤りがあります'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
