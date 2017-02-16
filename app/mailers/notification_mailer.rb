class NotificationMailer < ApplicationMailer
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

    def disabled_user_email(user)
        mail(to: user.email, subject: 'Sorry, your user account has been disabled')
    end
end
