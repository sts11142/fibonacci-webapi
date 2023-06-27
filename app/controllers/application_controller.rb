class ApplicationController < ActionController::API
  def hello
    render html: "hello world!"
  end
end
