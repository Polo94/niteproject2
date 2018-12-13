class ReviewsController < ApplicationController
  #layout "..."
  before_action :set_good, only: [:index, :show, :update]
  before_action :set_object, only: [:update]
  before_action :set_objects, only: [:index, :show]
  before_action :set_object_with_token, only: [:show]
  before_action :authenticate_user!, except: [:show, :update]

  def index

  end

  def show
    @token = params[:token]
  end


  def update
    if @object.token != "USED"
      @object.update(review_params)
      create = 1
      # dfinir ls variables de la review a envoyer dans le mail
      ApplicationMailer.token_confirm_email(@object.email).deliver
      @object.token = "USED"
      @object.is_visible = true
    elsif @object.token == "USED" && current_user && @object.token_confirm == "USED"
      visible = @object.is_visible ? false : true
      @object.update({is_visible: visible})
    end
    if @object.token_confirm != "USED" && !create
      @object.is_visible = true
      @object.token_confirm = "USED"
    end
    respond_to do |format|
      if @object.save
        @object.stars = ((@object.service_quality + @object.interlocutor_skills + @object.monitoring_care) / 3).round(2)
        @object.save
        #if mail == 1
        #ReviewValidationEmail.sample_email(@object.email).deliver

        # envoi de mail au buyer ou seller
        #

        format.html { redirect_to good_reviews_path(@good), notice: 'Review was successfully updated.'}
      else
        format.html { render :new }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :name,
      :nickname,
      :tel,
      :email,
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

    if params['token'] == @buyer.token && @buyer.token != "USED" || params['token'] == @buyer.token_confirm && @buyer.token_confirm != "USED"
      @object = @buyer

    elsif params['token'] == @seller.token && @seller.token != "USED" || params['token'] == @seller.token_confirm && @seller.token_confirm != "USED"
      @object = @seller

    ## else
      ## retourner une erreur
    end
  end

  def set_object
    @object = Review.find(params[:id])
  end

  def set_objects

    @seller = Review.find(@good.seller_id)
    @buyer = Review.find(@good.buyer_id)
  end
end
