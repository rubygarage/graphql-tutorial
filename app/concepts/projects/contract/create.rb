module Projects::Contract
  class Create < Reform::Form
    include Dry

    property :title

    validation do
      required(:title).filled(:str?)
    end
  end
end
