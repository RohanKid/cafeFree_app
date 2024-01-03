require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @employee = employees(:michael)
    @other_employee = employees(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_employee_path(@employee)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch employee_path(@employee), params: { employee: { name: @employee.name,
                                              email: @employee.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as noadmin user" do
    log_in_as(@other_employee)
    get edit_employee_path(@other_employee)
    assert_not flash.empty?
    assert_redirected_to employees_path
  end

  test "should redirect update when logged in as noadmin user" do
    log_in_as(@other_employee)
    patch employee_path(@other_employee), params: { employee: { name: @other_employee.name,
                                              email: @other_employee.email } }
    assert_not flash.empty?
    assert_redirected_to employees_path
  end

  test "should redirect index when not logged in" do
    get employees_path
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Employee.count' do
      delete employee_path(@employee)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_employee)
    assert_no_difference 'Employee.count' do
      delete employee_path(@employee)
    end
    assert_response :see_other
    assert_redirected_to employees_path
  end
end
