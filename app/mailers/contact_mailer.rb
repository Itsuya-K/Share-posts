class ContactMailer < ApplicationMailer
  def contact_mail(contact)
   @contact = contact

   mail to: "kawa.capri.0101@gmail.com", subject: "お問い合わせの確認メール"
  end
end
