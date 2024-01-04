class AttendancesController < ApplicationController
  before_action :logged_in_employee, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_employee, only: [:edit, :update, :destroy]

  def new
    if current_employee.attendance_flag == 0
      @attendance = current_employee.attendances.build
    else
      @attendance = Attendance.where(employee_id: current_employee.id).last
    end
  end
  
  def create
    if current_employee.attendance_flag == 0
      @attendance = current_employee.attendances.build(attendance_params_start)
      attendanceFlagParam = {attendance_flag: 1}
      if @attendance.save && current_employee.update(attendanceFlagParam)
        flash[:success] = "勤怠を登録しました。"
        redirect_to current_employee
      else
        render 'new', status: :unprocessable_entity
      end
    else
      @attendance = Attendance.where(employee_id: current_employee.id).last
      attendanceFlagParam = {attendance_flag: 0}
      if current_employee.update(attendanceFlagParam) && @attendance.update(attendance_params_end)
        flash[:success] = "勤怠を登録しました。"
        redirect_to current_employee
      else
        render 'new', status: :unprocessable_entity
      end
    end
  end

  def edit
    @attendance = Attendance.find(params[:id])
  end

  def update
    @attendance = Attendance.find(params[:id])
    if @attendance.update(attendance_params_edit)
      flash[:success] = "勤怠情報更新"
      redirect_to employee_path(@attendance.employee_id)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id]).destroy
    flash[:success] = "勤怠の削除に成功しました"
    redirect_to employee_path(@attendance.employee_id), status: :see_other
  end

  private

    def attendance_params_start
      params.require(:attendance).permit(:start_work_date)
    end

    def attendance_params_end
      params.require(:attendance).permit(:break_time, :end_work_date)
    end

    

    def attendance_params_edit
      params.require(:attendance).permit(:start_work_date, :break_time, :end_work_date, :attendance_modify_flag)
    end

end
