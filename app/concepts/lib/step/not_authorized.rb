class Lib::Step::NotAuthorized < Trailblazer::Operation
  step :restrict_access!

  def restrict_access!(_options, **)
    raise Pundit::NotAuthorizedError
  end
end
