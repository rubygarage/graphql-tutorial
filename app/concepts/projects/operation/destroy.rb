class Projects::Destroy < Trailblazer::Operation
  step :model!
  step :destroy!

  def model!(options, current_user:, params:, **)
    options[:model] = current_user.projects.find(params[:id])
  end

  def destroy!(_options, model:, **)
    model.destroy
  end
end
