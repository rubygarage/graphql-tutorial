class ApplicationController < ActionController::API
  include Trailblazer::Rails::Controller
  include Authenticable::User
end
