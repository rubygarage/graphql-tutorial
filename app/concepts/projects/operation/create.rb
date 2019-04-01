class Projects::Create < Trailblazer::Operation
  step :position!
  step :model!
  step Contract::Build(constant: Projects::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  def position!(ctx, current_user:, **)
    ctx[:position] = current_user.projects.count
  end

  def model!(ctx, current_user:, position:, **)
    ctx[:model] = current_user.projects.new(position: position)
  end
end
