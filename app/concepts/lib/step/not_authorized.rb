class Lib::Step::NotAuthorized < Trailblazer::Operation
  extend Uber::Callable

  def self.call(_ctx, **)
    raise Pundit::NotAuthorizedError
  end
end
