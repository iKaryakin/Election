class Camera < ApplicationRecord

  paginates_per 12

  before_validation(on: :create) do
    self.refer_area_code = area.area_code
  end

  belongs_to :area
end
