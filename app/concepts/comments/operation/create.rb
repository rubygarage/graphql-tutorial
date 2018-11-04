class Comments::Create < Trailblazer::Operation
  step :comment!
  step :model!
  step Contract::Build(constant: Comments::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  def comment!(options, current_user:, params:, **)
    options[:task] = current_user.tasks.find(params[:task_id])
  end

  def model!(options, task:, **)
    options[:model] = task.comments.new
  end
end
