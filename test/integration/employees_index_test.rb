require "test_helper"

class EmployeesIndexTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:michael)
  end

  test "index including pagination" do
    log_in_as(@employee)
    get employees_path
    assert_template 'employees/index'
    assert_select 'div.pagination'
    Employee.paginate(page: 1).each do |employee|
      assert_select 'a[href=?]', employee_path(employee), text: employee.name
    end
  end
end
