# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true
              )

99.times do |n|
  name = Faker::Name.name
  email = "sample#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

puts "Create User"
admin_user = User.first
guest_user = User.find(2)

50.times do |t|
  task_name = "タスク#{t+1}"
  task_description = "タスク詳細#{t+1}"
  admin_user.tasks.create!(name: task_name, description: task_description)
  guest_user.tasks.create!(name: task_name, description: task_description)
end

puts "Create Task"
  