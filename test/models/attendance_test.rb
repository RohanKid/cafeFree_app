require "test_helper"

class AttendanceTest < ActiveSupport::TestCase
  def setup
    @employee = employees(:michael)
    @attendance = @employee.attendances.build(start_work_date: "2024-01-03 11:37:04", end_work_date: "2024-01-03 16:37:04")
  end

  test "should be valid" do
    assert @attendance.valid?
  end

  test "employee id should be present" do
    @attendance.employee_id = nil
    assert_not @attendance.valid?
  end

  test "break_time should be present" do
    @attendance.break_time = nil
    assert_not @attendance.valid?
  end

  test "break_time should be more than 0" do
    @attendance.break_time = -1
    assert_not @attendance.valid?
  end

  test "break_time can be decimal" do
    @attendance.break_time = 1.5
    assert @attendance.valid?
  end

  test "order should be most older first" do
    assert_equal attendances(:tau_manifesto), Attendance.first
  end
end
