class Area < ApplicationRecord
    # self.primary_key = "area_slug"

    def to_param
        area_slug
    end

     before_validation(on: :create) do
        self.area_slug = ["area", area_code].join("-")
      end

    has_many :cameras, dependent: :destroy
    validates :area_code, uniqueness: true
    # https://www.youtube.com/embed/U8v16kFEt-o
end
