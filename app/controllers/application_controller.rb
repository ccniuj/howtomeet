require 'oauth'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  HACKPAD_SERVER = URI.parse(URI.encode(ENV['HACKPAD_SERVER'].strip))
  HACKPAD_CLIENT_ID = ENV['HACKPAD_CLIENT_ID']
  HACKPAD_SECRET = ENV['HACKPAD_SECRET']

  def hackpad
    @@hackpad ||= OAuth::Consumer.new HACKPAD_CLIENT_ID, HACKPAD_SECRET, {
      :site => HACKPAD_SERVER,
    }
  end
end
