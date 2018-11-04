class Projects::Create < Trailblazer::Operation
  step :position!
  step :model!
  step Contract::Build(constant: Projects::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  def position!(options, current_user:, **)
    options[:position] = current_user.projects.count
  end

  def model!(options, current_user:, position:, **)
    options[:model] = current_user.projects.new(position: position)
  end
end
