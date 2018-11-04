FactoryBot.define do
  factory :task do
    name { FFaker::DizzleIpsum.word }
    done { false }
    project { nil }
    position { rand(0..5) }
  end
end
