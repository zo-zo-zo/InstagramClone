class CheckMailer < ApplicationMailer

  def check_mail(blog)
    @blog = blog
    mail to: @blog.user.email, subject: "画像投稿確認メール"
  end
end
