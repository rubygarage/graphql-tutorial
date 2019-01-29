class Users::Show < Trailblazer::Operation
  step :model!

  def model!(ctx, params:, **)
    ctx[:model] = User.find_by!(id: params[:id])
  end
end
