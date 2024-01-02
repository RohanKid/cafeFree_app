class AddPasswordDigestToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :password_digest, :string
    add_column :employees, :attendance_flag, :integer, default: 0
    add_column :employees, :hourly_wage, :integer, default: 0
    add_column :employees, :admin_flag, :integer, default: 0
  end
end
