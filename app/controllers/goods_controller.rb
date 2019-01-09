class GoodsController < ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy, :opinion, :details]
  before_action :set_goods, only: [:home]
  before_action :set_variables, only: [:details]
  before_action :authenticate_user!, except: [:home, :details]
  before_action :set_user, only: [:agency_index]

  def agency_index
    @goods = Good.where(user_id: @user.id).order(created_at: :desc).limit(10)
  end

  # GET /goods
  # GET /goods.json
  def index
    @goods = Good.where(user_id: current_user.id).order(created_at: :desc)
    @goods = Good.page(params[:page]).per(5)


  end

  # GET /goods/1
  # GET /goods/1.json
  def show

  end

  # GET /goods/new
  def new
    @good = current_user.goods.build
  end

  # GET /goods/1/edit
  def edit
  end

  def home

    @goods = Good.order(created_at: :desc).page(params[:page]).per(4)
    @num_reviews = Review.where(is_visible: true).size
    #@goods = Good.page(params[:page])
    #@goods = Good.page(params[:page])


  end

  def details
  end

  # POST /goods
  # POST /goods.json
  def create
    @good = current_user.goods.build(good_params.merge({"property_type" =>  Integer(good_params["property_type"])}))

    respond_to do |format|
      if @good.save
        @good.seller_id = Review.create({token: (rand(500..5000) * @good.id + @good.title.length), is_visible: false, token_confirm: (rand(500..5000) * @good.id + @good.title.length)}).id
        @good.buyer_id = Review.create({token: (rand(500..5000) * @good.id + @good.title.length), is_visible: false, token_confirm: (rand(500..5000) * @good.id + @good.title.length)}).id
        @good.save!
        format.html { redirect_to good_reviews_path(@good), notice: "#{t("application.good.notice_creation")}" }
        format.json { render :show, status: :created, location: @good }
      else
        format.html { render :new }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goods/1
  # PATCH/PUT /goods/1.json
  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to @good, notice: "#{t("application.good.update_notice")}" }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1
  # DELETE /goods/1.json
  def destroy
    @good.destroy
    respond_to do |format|
      format.html { redirect_to goods_url, notice: 'Good was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # Add and remove goods to opinion
  # for current_user
  def opinion
    type = params[:type]

    if type == "add"
      current_user.opinion_additions << @good
      redirect_to opinion_index_path, notice: "#{@good.title} was added to your opinions"

    elsif type == "remove"
      current_user.opinion_additions.delete(@good)
      redirect_to root_path, notice: "#{@good.title} was removed from your opinions"
    else
      # Type missing, nothing happens
      redirect_to good_path(@good), notice: "Looks like nothing happened. Try once more!"
    end

end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good
      @good = Good.find(params[:id])
    end

    def set_goods
      @goods = Good.joins("LEFT OUTER JOIN reviews ON (goods.seller_id = reviews.id OR goods.buyer_id =reviews.id)").where("reviews.token = 'USED' AND reviews.is_visible = 1").uniq
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params.require(:good).permit(:thumbnail, :title, :property_type, :location, :user_id)
    end

    def set_variables

      buyer = @good.buyer_id ? Review.find(@good.buyer_id) : nil
      seller = @good.seller_id ? Review.find(@good.seller_id) : nil
      @buyer = buyer && buyer.token == 'USED' && buyer.is_visible ? buyer : nil
      @seller = seller && seller.token == 'USED' && seller.is_visible ? seller : nil
    end

    def set_user
      @user = User.find(params[:agency_id])
    end
end
