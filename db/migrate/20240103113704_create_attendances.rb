class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true
      t.datetime :start_work_date, null: true
      t.datetime :end_work_date, null: true
      t.float :break_time, default: 0
      t.integer :attendance_modify_flag, default: 0

      t.timestamps
    end
    add_index :attendances, [:employee_id, :created_at]
  end
end
