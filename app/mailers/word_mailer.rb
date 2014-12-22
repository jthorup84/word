class WordMailer < ActionMailer::Base
  default from: "dailyword@jthorup.com"
  def new_word_email(member)
    @member = member
    @url  = 'https://dailywordguess.herokuapp.com/welcome/index'
    mail(to: @member.email, subject: 'Ready to guess the Word?')
  end
end
