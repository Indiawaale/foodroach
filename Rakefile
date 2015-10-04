# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

desc 'Send notif'
task send_gcm: :environment do
    abcd = SocialController.new
    abcd.notify
end
Rails.application.load_tasks
