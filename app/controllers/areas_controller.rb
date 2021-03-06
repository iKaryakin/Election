class AreasController < ApplicationController
  
  def index
    # @areas = Area.all
    @areas = if params[:term]
      Area.where("address LIKE ? OR area_code LIKE ?", "%#{params[:term]}%","%#{params[:term]}%")
    else
      Area.all
    end
    # @areas_json = @areas.to_json
    @areas_arr = @areas.map do |item|
      { number: item.area_code,
        address: item.address,
        coordinates: JSON.parse( item.coordinates) ,
        phone: item.phone_number,
        area_slug: item.area_slug,
        url: "/areas/" + item.area_slug }
    end
    respond_to do |format|
      format.html
      format.json { render json: @areas_arr }
  end  
  end

  def show
    @area = Area.find_by!(area_slug: params[:area_slug])
  end
 
  def new
    @area = Area.new
  end
 
  def edit
    @area = Area.find_by!(area_slug: params[:area_slug])
  end
 
  def create
    @area = Area.new(area_params)
 
    if @area.save
      redirect_to @area
    else
      render 'new'
    end
  end
 
  def update
    @area = Area.find_by!(area_slug: params[:area_slug])
 
    if @area.update(area_params)
      redirect_to @area
    else
      render 'edit'
    end
  end
 
  def destroy
    @area = Area.find_by!(area_slug: params[:area_slug])
    @area.destroy
 
    redirect_to areas_path
  end

  private
    def area_params
      params.require(:area).permit(:area_code, :address, :phone_number, :area_slug, :term)
    end
end
