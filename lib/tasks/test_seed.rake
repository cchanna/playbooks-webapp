namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:reset"].invoke
    end
  end
end
