class Comments::Create < Trailblazer::Operation
  step :comment!
  step :model!
  step Contract::Build(constant: Comments::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  def comment!(ctx, current_user:, params:, **)
    ctx[:task] = current_user.tasks.find(params[:task_id])
  end

  def model!(ctx, task:, **)
    ctx[:model] = task.comments.new
  end
end
