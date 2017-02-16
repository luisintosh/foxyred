
desc 'Notification for payment to members'
task payout_notification: :environment do
    # Run only on selected days
    payout_days = Option.get(:paydays).split(',').map(&:to_i)
    next unless payout_days.include? Time.now.day
    puts "Today is a payout day: #{Time.now.day}"

    available_wds = Withdrawal.where 'created_at <= ?', (Time.now-1.month)
    total_amount = available_wds.sum :amount
    total_users = available_wds.count

    # Send notification
    NotificationMailer.payout_day_email(total_amount, total_users).deliver_now
end