class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.text :area_code
      t.text :address
      t.float :latitude
      t.float :longitude
      t.text :phone_number
      t.string :area_slug

      t.timestamps
    end
    # add_index :areas, :area_code
  end
end
