FactoryBot.define do
  factory :comment do
    body { FFaker::DizzleIpsum.paragraph }
    task { nil }
    attachment { nil }
  end
end
