class Projects::Destroy < Trailblazer::Operation
  step :model!
  step :destroy!

  def model!(ctx, current_user:, params:, **)
    ctx[:model] = current_user.projects.find(params[:id])
  end

  def destroy!(_ctx, model:, **)
    model.destroy
  end
end
