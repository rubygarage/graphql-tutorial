class Tasks::Update < Trailblazer::Operation
  step :model!
  step Contract::Build(constant: Tasks::Contract::Update)
  step Contract::Validate()
  step Contract::Persist()

  def model!(ctx, current_user:, params:, **)
    ctx[:model] = current_user.tasks.find(params[:id])
  end
end
