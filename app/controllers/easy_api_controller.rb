class EasyApiController < ApplicationController
  def index
    render json: { status: 200, message: "Thanks!" }
  end
end
