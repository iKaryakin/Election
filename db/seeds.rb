# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Area.create(area_code: '2', address: "ул.Ленина 21", phone_number: '8 999 229 44 80' )
Area.create(area_code: '1', address: "ул.Ленина 10", phone_number: '7 999 229 44 80', area_slug: 'area-1' )