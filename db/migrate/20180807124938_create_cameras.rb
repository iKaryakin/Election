class CreateCameras < ActiveRecord::Migration[5.2]
  def change
    create_table :cameras do |t|
      t.string :camera_number
      t.text :link
      t.text :refer_area_code
      t.references :area, foreign_key: true

      t.timestamps
    end
  end
end
