
desc 'Cash closing for user earnings'
task cash_closing: :environment do
    # Run only on selected days
    payout_days = Option.get(:paydays).split(',').map(&:to_i)
    next unless payout_days.include? Time.now.day
    puts "Today is a cash closing day: #{Time.now.day}"

    min_withdrawal_amount = Option.get(:min_withdrawal_amount)
    # Get user's balance with amounts greater than min withdrawal amount
    available_balances = Balance.where('publisher_earnings + referral_earnings >= ?', min_withdrawal_amount)
    total_amount = 0.0
    
    available_balances.each do |b|
        ActiveRecord::Base.transaction do
            user = User.find b.user_id
            # Skip if method or account doesn't exist
            next unless (user.withdrawal_method? || user.withdrawal_account?)
            # Skip if method isn't available to use
            next unless Withdrawal.has_available_wd_method? user

            # Create new withdrawal
            total_sum = b.publisher_earnings + b.referral_earnings
            user.withdrawals.create publisher_earnings: b.publisher_earnings, 
                                    referral_earnings: b.referral_earnings,
                                    amount: total_sum,
                                    method: user.withdrawal_method,
                                    account: user.withdrawal_account,
                                    transaction_id: "#{Time.now.strftime('%y%m%d')}#{user.id}",
                                    status: :pending
            
            # Clean current balance
            b.publisher_earnings = 0.0
            b.referral_earnings = 0.0
            b.save   

            puts "User #{user.email} has generated #{amount}"
            total_amount += amount
        end
    end

    # Send notification of cash closing
    #NotificationMailer.cash_closing_email(total_amount, available_balances.count).deliver!
end