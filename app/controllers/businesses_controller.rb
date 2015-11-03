class BusinessesController < ApplicationController
  def new
    @business = Business.new
  end

  def create
    @business = Business.new(params[:business].permit(:name, :description, :picture_url))

    if @business.save
      flash[:success] = "New business listed!"
      redirect_to businesses_path
    else
      flash[:danger] = "There were some problems."
      render :new
    end
  end

  def index
    @col1 = []; @col2 = []; @col3 = []
    Business.all.each_slice(3) do |first, second, third|
      @col1.push(first) if first
      @col2.push(second) if second
      @col3.push(third) if third
    end
  end
end

