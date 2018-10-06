class ReviewsController < ApplicationController
  #layout "..."
  before_action :set_good, only: [:index, :show, :update]
  before_action :set_object_with_token, only: [:show]
  before_action :set_object, only: [:update]
  before_action :set_objects, only: [:index]

  def index
  end

  def show
  end

  def update
    if @object.token != "USED"
      @object.update(review_params)
      @object.token = "USED"
      respond_to do |format|
        if @object.save
          format.html { redirect_to good_reviews_path(@good), notice: 'Review was successfully created.'}
        else
          format.html { render :new }
        end
      end
    end
  end
  private

  def review_params
    params.require(:review).permit(
      :stars,
      :service_quality,
      :interlocutor_skills,
      :monitoring_care,
      :company_recommendation,
      :testimony)
  end

  def set_good
    @good = Good.find(params[:good_id])
  end

  def set_object_with_token
    if params['token'] == @good.buyer.token && @good.buyer.token != "USED"
      @object = @good.buyer
    elsif params['token'] == @good.seller.token && @good.seller.token != "USED"
      @object = @good.seller
    ## else
      ## retourner une erreur
    end
  end

  def set_object
    @object = Review.find(params[:id])
  end

  def set_objects
    @seller = @good.seller
    @buyer = @good.buyer
  end
end
