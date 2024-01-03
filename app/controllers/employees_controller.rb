class EmployeesController < ApplicationController
  before_action :logged_in_employee, only: [:index, :show, :edit, :update, :destroy]
  before_action :admin_employee, only: [:edit, :update, :destroy]

  def index
    @employees = Employee.paginate(page: params[:page])
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      reset_session
      log_in @employee
      flash[:success] = "こんにちは！"
      redirect_to @employee
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params_edit)
      flash[:success] = "情報更新"
      redirect_to @employee
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    Employee.find(params[:id]).destroy
    flash[:success] = "削除に成功しました"
    redirect_to employees_url, status: :see_other
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def employee_params_edit
      params.require(:employee).permit(:name, :email, :hourly_wage)
    end

    # beforeフィルタ

    # ログイン済みemployeeかどうか確認
    def logged_in_employee
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    # adminemployeeかどうか確認
    def admin_employee
      if current_employee.admin_flag != 1
        flash[:danger] = "この操作の権限がありません。"
        redirect_to employees_path, status: :see_other
      end
    end
end
