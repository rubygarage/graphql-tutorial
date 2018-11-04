class AuthenticationController < ApplicationController
  before_action :authenticate_user

  private

  def _run_options(options)
    options.merge('current_user' => current_user)
  end
end
