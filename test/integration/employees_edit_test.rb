require "test_helper"

class EmployeesEditTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@employee)
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    patch employee_path(@employee), params: { employee: { name:  "",
                                              email: "foo@invalid",
                                              hourly_wage: "w"} }
    assert_template 'employees/edit'
  end

  test "successful edit" do
    log_in_as(@employee)
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch employee_path(@employee), params: { employee: { name:  name,
                                              email: email,
                                              hourly_wage: "2000"} }
    assert_not flash.empty?
    assert_redirected_to @employee
    @employee.reload
    assert_equal 2000,  @employee.hourly_wage
  end
end
