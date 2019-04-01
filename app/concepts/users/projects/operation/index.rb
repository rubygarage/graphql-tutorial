class Users::Projects::Index < Trailblazer::Operation
  step Policy::Guard(Users::Projects::Lib::Policy::IndexGuard.new)
  fail ::Lib::Step::NotAuthorized

  step :model!

  def model!(ctx, object:, **)
    ctx[:model] = object.projects
  end
end
