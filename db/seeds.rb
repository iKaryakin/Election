# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'table3.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8', :col_sep => ";" )
csv.each do |row|
    Area.create( area_code: row["area_code"], address: row["address"],
         phone_number: row["phone_number"], coordinates: row["coordinates"] )

  end

puts csv_text

csv_users = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
csv2 = CSV.parse(csv_users, :headers => true, :encoding => 'UTF-8', :col_sep => ";" )
csv2.each do |row|
    User.create( username: row["username"], password: row["password"],
        password_confirmation: row["password_confirmation"], )
  end

puts csv_users

csv_cams = File.read(Rails.root.join('lib', 'seeds', 'cams2.csv'))
csv3 = CSV.parse(csv_cams, :headers => true, :encoding => 'UTF-8', :col_sep => ";" )
csv3.each do |row|

    @area = Area.find_by!(area_slug: "area-"+row["area"])
    # @area.cameras.create(camera_number: row["cam"], link: "http://95.213.252.82/" + row["serial"] + "/")

    if (row["cam"] == "cam1")
          @area.cameras.create(camera_number: "1", link: "http://95.213.252.82/" + row["serial"] + "/")
    else
          @area.cameras.create(camera_number: "2", link: "http://95.213.252.82/" + row["serial"] + "/")
    end
  end

puts csv_cams


# require "json"
# json_from_file = File.read(Rails.root.join('lib', 'seeds', 'active_cameras.json'))
# # puts json_from_file
# hash = JSON.parse(json_from_file)
# cameras_hash = hash['cameras']

# puts hash["cameras"]["device_name"]


# puts cameras_hash.map{ |hash| hash['device_name'] + " " + hash['serial'] } #, cameras_hash.map { |hash| hash['serial'] }