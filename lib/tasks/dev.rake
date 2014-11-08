namespace :dev do
  desc 'Generate test data'
  task :fake do
    puts 'this is a fake'
    FactoryGirl.create(:user)
  end
end
