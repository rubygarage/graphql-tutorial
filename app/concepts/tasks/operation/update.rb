class Tasks::Update < Trailblazer::Operation
  step :model!
  step Contract::Build(constant: Tasks::Contract::Update)
  step Contract::Validate()
  step Contract::Persist()

  def model!(options, current_user:, params:, **)
    options[:model] = current_user.tasks.find(params[:id])
  end
end
