class EmployeesController < ApplicationController
  before_action :logged_in_employee, only: [:index, :show, :edit, :update, :destroy]
  before_action :admin_employee, only: [:edit, :update, :destroy]
  before_action :admin_or_current, only: [:show]

  def index
    @employees = Employee.order("id asc").paginate(page: params[:page])
  end

  def show
    @year = params["date(1i)"] || Date.today.year
    @month = params["date(2i)"] || Date.today.month
    @year = @year.to_i
    @month = @month.to_i
    @employee = Employee.find(params[:id])
    @attendances = @employee.attendances.where(start_work_date: Date.new(@year,@month,1)..Date.new(@year,@month,1).next_month)
    @all_work_time = 0
    @attendances.each do |attendance|
      if attendance.end_work_date != nil
        @all_work_time += attendance.end_work_date - attendance.start_work_date
      end
    end
    @all_work_time /= 3600
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
end
