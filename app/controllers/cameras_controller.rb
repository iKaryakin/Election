class CamerasController < ApplicationController

    def index
        @cameras = Camera.all   
        # @areas = Area.all 
    end

    def show
        @area = Area.find_by!(area_slug: params[:camera_area_slug])
        @camera = @area.cameras.find(params[:id])
    end

    def create
        @area = Area.find_by!(area_slug: params[:area_area_slug])
        @camera = @area.cameras.create(camera_params)
        redirect_to area_path(@area)
    end

    def destroy
        @area = Area.find_by!(area_slug: params[:area_area_slug])
        @camera = @area.cameras.find(params[:id])
        @camera.destroy
        redirect_to area_path(@area)
    end
     
      private
        def camera_params
          params.require(:camera).permit(:camera_number, :link, :area_id)
        end
end
