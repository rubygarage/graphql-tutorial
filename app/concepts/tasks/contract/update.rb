module Tasks::Contract
  class Update < Reform::Form
    include Dry
    feature Coercion

    property :name
    property :done
    property :position

    validation do
      optional(:name).filled(:str?)
      optional(:done).filled(:bool?)
      optional(:position).filled(:int?, gteq?: 0)
    end
  end
end
