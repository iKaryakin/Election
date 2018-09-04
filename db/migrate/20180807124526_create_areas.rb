class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.text :area_code
      t.text :address
      t.text :coordinates
      # t.float :latitude
      # t.float :longitude
      t.text :phone_number
      t.string :area_slug

      t.timestamps
    end
  end
end
