module App
  class BaseController < ApplicationController
    protect_from_forgery with: :exception
  end
end
