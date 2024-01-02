class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)    # 実装は終わっていないことに注意!
    if @employee.save
      flash[:success] = "おかえりなさい"
      redirect_to @employee
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
