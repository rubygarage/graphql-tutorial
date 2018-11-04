FactoryBot.define do
  factory :project do
    title { FFaker::DizzleIpsum.word }
    user { nil }
    position { rand(0..5) }
  end
end
