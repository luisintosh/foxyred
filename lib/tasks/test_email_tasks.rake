
desc 'Send test notification'
task test_email: :environment do
    # Send notification
    NotificationMailer.test_notification_email('foxydotred@gmail.com').deliver_now
end