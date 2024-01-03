# メインのサンプルユーザーを1人作成する
Employee.create!(name:  "Example Employee",
  email: "example@gmail.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin_flag: 1)

# 追加のユーザーをまとめて生成する
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
Employee.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end
