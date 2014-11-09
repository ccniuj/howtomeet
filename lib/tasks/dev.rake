require 'factory_girl_rails' #so it can run in development
namespace :dev do
  desc 'Generate test data'
  task :fake => :environment do
    puts 'this is a fake'
    FactoryGirl.create_list(:category_with_meetup, 3) 
  end
end
