class Projects::Update < Trailblazer::Operation
  step :model!
  step Contract::Build(constant: Projects::Contract::Update)
  step Contract::Validate()
  step Contract::Persist()

  def model!(ctx, current_user:, params:, **)
    ctx[:model] = current_user.projects.find(params[:id])
  end
end
