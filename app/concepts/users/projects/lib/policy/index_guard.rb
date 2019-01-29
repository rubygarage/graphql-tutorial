class Users::Projects::Lib::Policy::IndexGuard
  include Uber::Callable

  def call(_ctx, current_user:, object:, **)
    current_user == object
  end
end
