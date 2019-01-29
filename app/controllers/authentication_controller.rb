class AuthenticationController < ApplicationController
  before_action :authenticate_user

  private

  def _run_options(ctx)
    ctx.merge(current_user: current_user)
  end
end
