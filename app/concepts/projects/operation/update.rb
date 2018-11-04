class Projects::Update < Trailblazer::Operation
  step :model!
  step Contract::Build(constant: Projects::Contract::Update)
  step Contract::Validate()
  step Contract::Persist()

  def model!(options, current_user:, params:, **)
    options[:model] = current_user.projects.find(params[:id])
  end
end
