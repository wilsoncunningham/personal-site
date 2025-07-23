namespace :notebook do
  desc "Seed 5 sample notebook entries"
  task seed_sample: :environment do
    require 'faker'

    puts "Creating 5 sample notebook entries..."

    5.times do |i|
      NotebookEntry.create!(
        title: Faker::Book.title,
        content: Faker::Lorem.paragraphs(number: rand(2..5)).join("\n\n"),
        entry_type: "thought",
        is_public: [true, true, false].sample,
        is_pinned: [true, false].sample
      )
    end

    puts "✅ 5 notebook entries created."
  end
end
