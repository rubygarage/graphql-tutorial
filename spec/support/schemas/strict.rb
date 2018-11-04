# At this moment Dry::Validation 0.11.1 does not provide error handlers
# for unexpected params. But it will be implemented in v 1.0.
# Source: https://github.com/dry-rb/dry-validation/issues/179

class Strict < Dry::Validation::Schema
  def strict_keys?(input)
    (input.keys - rules.keys).empty?
  end

  def self.messages
    super.merge(en: { errors: { strict_keys?: 'has unknown keys' } })
  end
end
