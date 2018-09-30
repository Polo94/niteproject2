class OpinionController < ApplicationController
  before_action :authenticate_user!

  def index
    @opinion_goods = current_user.opinion_additions
end
end
