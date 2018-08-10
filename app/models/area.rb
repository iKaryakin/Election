class Area < ApplicationRecord
    def to_param
        area_slug
    end

     before_validation(on: :create) do
        self.area_slug = ["area", area_code].join("-")
      end

    has_many :cameras
end
