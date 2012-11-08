# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

every :day, :at => '3:00 am' do
  runner "Clip.delete_expired_clips"
end

# Learn more: http://github.com/javan/whenever
