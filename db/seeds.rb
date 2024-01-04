# メインのサンプルユーザーを1人作成する
Employee.create!(name:  "admin Employee",
  email: "admin@gmail.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin_flag: 1)

  # サブのサンプルユーザーを1人作成する
Employee.create!(name:  "free Employee",
  email: "free@gmail.org",
  password:              "password",
  password_confirmation: "password")

# 追加のemployeeをまとめて生成する
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@gmail.org"
password = "password"
Employee.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end

# employeeの一部を対象勤怠実績を生成する
employees = Employee.order(:created_at).take(6)
employees.each { |employee| employee.attendances.create!(start_work_date: "2024-01-03 11:37:04", end_work_date: "2024-01-03 17:37:04", break_time: 1) }
employees = Employee.order(:created_at).take(6)
employees.each { |employee| employee.attendances.create!(start_work_date: "2024-01-02 11:37:04", end_work_date: "2024-01-02 19:37:04", break_time: 1.5) }
employees = Employee.order(:created_at).take(6)
employees.each { |employee| employee.attendances.create!(start_work_date: "2024-01-01 12:37:04", end_work_date: "2024-01-01 19:37:04", break_time: 0.5) }
employees = Employee.order(:created_at).take(6)
employees.each { |employee| employee.attendances.create!(start_work_date: "2023-12-28 11:37:04", end_work_date: "2023-12-28 17:37:04", break_time: 1) }
employees = Employee.order(:created_at).take(6)
employees.each { |employee| employee.attendances.create!(start_work_date: "2023-12-26 11:37:04", end_work_date: "2023-12-26 15:37:04", break_time: 1.0) }
employees = Employee.order(:created_at).take(6)
employees.each { |employee| employee.attendances.create!(start_work_date: "2023-12-25 11:37:04", end_work_date: "2023-12-25 19:37:04", break_time: 1.2) }

