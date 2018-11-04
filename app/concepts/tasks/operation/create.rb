class Tasks::Create < Trailblazer::Operation
  step :project!
  step :model!
  step Contract::Build(constant: Tasks::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
  step :update_tasks_positions!

  def project!(options, current_user:, params:, **)
    options[:project] = current_user.projects.find(params[:project_id])
  end

  def model!(options, project:, **)
    options[:model] = project.tasks.new
  end

  def update_tasks_positions!(_options, model:, project:, **)
    project.tasks.where.not(id: model.id).each { |task| task.update(position: task.position + 1) }
  end
end
