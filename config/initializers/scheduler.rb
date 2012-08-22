require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.in '20m' do
  puts "order ristretto"
end

scheduler.at 'Thu Mar 26 07:31:43 +0900 2009' do
  puts 'order pizza'
end

scheduler.cron '0 22 * * 1-5' do
  # every day of the week at 22:00 (10pm)
  puts 'activate security system'
end

scheduler.every '1h' do
  RawFileTransformer.transform
end
