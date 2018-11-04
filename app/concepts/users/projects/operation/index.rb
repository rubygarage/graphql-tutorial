class Users::Projects::Index < Trailblazer::Operation
  step Policy::Guard(Users::Projects::Lib::Policy::IndexGuard.new)
  failure Nested(::Lib::Step::NotAuthorized)

  step :model!

  def model!(options, object:, **)
    options[:model] = object.projects
  end
end
