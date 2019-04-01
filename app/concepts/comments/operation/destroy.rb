class Comments::Destroy < Trailblazer::Operation
  step :model!
  step :destroy!

  def model!(ctx, current_user:, params:, **)
    ctx[:model] = current_user.comments.find(params[:id])
  end

  def destroy!(_ctx, model:, **)
    model.destroy
  end
end
