class PagesController < ApplicationController
  def index
    @meetups = Meetup.all.order("created_at DESC").limit(3)
  end
end
