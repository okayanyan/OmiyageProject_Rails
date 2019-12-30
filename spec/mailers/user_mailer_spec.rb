require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) {FactoryBot.create(:test_user_non_activate)}
  let(:text_body) do
    part = mail.body.parts.detect{|part| part.content_type = 'text/plain; charset=UTF-8'}
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect{|part| part.content_type = 'text/html; charset=UTF-8'}
    part.body.raw_source
  end

  before do
    # create activation token
    user.prepare_activate
    user.save
  end

  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user) }

    it "create valid information" do
      # header
      expect(mail.subject).to eq("アカウント仮作成の確認")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreplay-#{ENV['SERVICE_EMAIL']}"])

      # body(text format)
      expect(text_body).to match('みやログのアカウント仮登録')
      expect(text_body).to match("ようこそ、#{user.name}さん！")
      expect(text_body).to match('仮登録ありがとうございます。')
      expect(text_body).to match('アカウントを有効化する')

      # body(html format)
      expect(html_body).to match('みやログのアカウント仮登録')
      expect(html_body).to match("ようこそ、#{user.name}さん！")
      expect(html_body).to match('仮登録ありがとうございます。')
      expect(html_body).to match('アカウントを有効化する')
    end
  end

end
