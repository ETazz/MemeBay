class ListingsController < ApplicationController
  before_action :authenticate_memeber!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]
  def index
    @listings = Listing.all
  end

  def category
    
  end

  def show

    
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_memeber.listings.new(listing_params)
    if @listing.save 
      redirect_to @listing, notice: "Listing succesfully created"
    else
      pp @listing.errors
      set_form_vars
      render "new", notice: "Something went wrong"
  end
end

  def edit

  end

  def update
    @Listing.update(listing_params)
    if @listing.save 
      redirect_to @listing, notice: "Listing succesfully updated"
    else
      pp @listing.errors
      set_form_vars
      render "edit", notice: "Something went wrong"
  end
  end

  def destroy
    @listing.destroy
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :price, :category_id, :description, :picture)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def set_form_vars
    @categories = Category.all
  end

end

