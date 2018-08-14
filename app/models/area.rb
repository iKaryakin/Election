class Area < ApplicationRecord
    def to_param
        area_slug
    end
    
    require 'russian'
    before_validation(on: :create) do
        self.area_slug = ["area", Russian.translit(area_code).parameterize].join("-")
    end

    has_many :cameras, dependent: :destroy
    validates :area_code, uniqueness: true
    # https://www.youtube.com/embed/U8v16kFEt-o
end
