class FbController < ApplicationController
  def index
    render json: { message: "init" }
  end
end
