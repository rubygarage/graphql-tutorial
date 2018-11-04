class Users::Projects::Lib::Policy::IndexGuard
  include Uber::Callable

  def call(_options, current_user:, object:, **)
    current_user == object
  end
end
