class NotificationMailer < ApplicationMailer
    default from: ENV['MAILER_SENDER'] || 'no-reply@localhost.com'
    layout 'mailer'

    def cash_closing_email(total_amount, total_users)
        @total_amount = total_amount
        @total_users = total_users
        @next_pay_day = Withdrawal.next_pay_day
        @payments_email = Option.get :payments_email
        now = Time.now.strftime('%Y-%m-%d')
        mail(to: @payments_email, subject: "New Cash Closing - Amount: #{@total_amount}, #{now}")
    end

    def payout_day_email(total_amount, total_users)
        @total_amount = total_amount
        @total_users = total_users
        @payments_email = Option.get :payments_email
        now = Time.now.strftime('%Y-%m-%d')
        mail(to: @payments_email, subject: "Payout day! - Amount: #{@total_amount}, #{now}")
    end
end
