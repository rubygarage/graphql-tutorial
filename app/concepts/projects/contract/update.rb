module Projects::Contract
  class Update < Reform::Form
    include Dry

    property :title
    property :position

    validation do
      optional(:title).filled(:str?)
      optional(:position).filled(:int?, gteq?: 0)
    end
  end
end
