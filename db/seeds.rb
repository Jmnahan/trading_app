# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all

10.times do |n|
    user = User.new email: "user#{n}@email.com", password: 'password'
    user.skip_confirmation!
    user.save
end


admin = User.new email: 'admin1@email.com', password: 'password', role: :admin

admin.skip_confirmation!

admin.save