module SessionsHelper
  # 渡されたemployeeでログインする
  def log_in(employee)
    session[:employee_id] = employee.id
  end

  # 現在ログイン中のemployeeを返す（いる場合）
  def current_employee
    if session[:employee_id]
      @current_employee ||= Employee.find_by(id: session[:employee_id])
    end
  end

  # employeeがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_employee.nil?
  end

  # 現在のemployeeをログアウトする
  def log_out
    reset_session
    @current_employee = nil   # 安全のため
  end
end
