class HomeController < ApplicationController
  def index
    @courses = Course.limit(Settings.home.courses_limit)
    @trainers = User.trainers.order_to_display.includes(:image)
      .limit Settings.home.trainers_limit
    @course = Course.find_by on_slider_index: true
  end
end
