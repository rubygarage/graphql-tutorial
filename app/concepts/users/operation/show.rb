class Users::Show < Trailblazer::Operation
  step :model!

  def model!(options, params:, **)
    options[:model] = User.find_by!(id: params[:id])
  end
end
