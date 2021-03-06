class ListingsController < ApplicationController
  before_action :authenticate_memeber!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # This before action secures listings
  before_action :authorize_memeber, only: [:edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]
  def index
    @listings = Listing.all
  end

  def category
    
  end

  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email:current_memeber && current_memeber.email,
      line_items: [
        {
          # Shows the listing information
          name: @listing.title,
          description: @listing.description,
          amount: @listing.price,
          currency: 'aud',
          quantity: 1
        }
      ],
      payment_intent_data: {
        metadata: {
          memeber_id: current_memeber && current_memeber.id,
          listing_id: @listing.id
        }
      },
      success_url: "#{root_url}/payments/success/#{@listing.id}",
      cancel_url: root_url
    )

    @session_id = session.id 

    
  end

  def new
    @listing = Listing.new
  end
# Create a new listings
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
# Updates listing
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
# This deletes/ destroys listed item
  def destroy
    @listing.destroy
    redirect_to listings_path, notice: "sucessfully deleted"
  end

  
  private

  def listing_params
    params.require(:listing).permit(:title, :price, :category_id, :description, :picture)
  end
#checks to see if the user is authorised to access a certain page or area of the application
  def authorize_memeber
    if @listing.memeber_id != current_memeber.id
      flash[:alert] = "You don't have permision to do that"
      redirect_to listing_path
    end
  end


  def set_listing
    @listing = Listing.find(params[:id])
  end

  def set_form_vars
    @categories = Category.all
  end

end

