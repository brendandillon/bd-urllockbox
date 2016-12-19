class Api::V1::LinksController < ApplicationController

  def create
    @link = Link.new(link_params)
    if @link.save
      render json: @link, status: 201
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def index
    @links = Link.where(user_id: current_user)
    render json: @links
  end

  private

  def link_params
    params.permit(:title, :url).merge(user_id: current_user.id)
  end
end
