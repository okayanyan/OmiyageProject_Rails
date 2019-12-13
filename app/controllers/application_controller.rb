class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ErrorsHelper
  include ApplicationHelper
  include SessionsHelper
end
