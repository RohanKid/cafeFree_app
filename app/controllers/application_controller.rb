class ApplicationController < ActionController::Base
  include SessionsHelper

  private

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

    def admin_or_current
      if current_employee.admin_flag != 1 && current_employee.id != params[:id].to_i
        flash[:danger] = "この操作の権限がありません。"
        redirect_to employees_path, status: :see_other
      end
    end
end
