# frozen_string_literal: true

# HomeController
class HomeController < ApplicationController
  def index
    @home_service = HomeService.new
  end
end
