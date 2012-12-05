FactoryGirl.define do
  factory :clip, :class=>"Clipster::Clip" do
    trait :expired do
      expires DateTime.now
    end
    
    trait :private do
      private true
    end
    
    clip "puts 'Hello World!'"
  end
end