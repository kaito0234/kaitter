namespace :false_user_logincondition do
  desc "全ユーザーのloginconditionをfalseにする"
  task false: :environment do
    #ここから処理を書いていく
    #定期実行する際に、そのログを取っておくのは大事。ログがないと定期実行でエラーが起きても分からない。
    logger = Logger.new 'log/false_user_condition.log'

    #全てのユーザーを取得していく
    #eachを使うと全てのユーザーがメモリに載せられてしまうが、find_eachにすることで1000件ずつ読み込んでメモリに展開される ユーザー数が多いならfind_eachを使った方が安全
    User.find_each do |user|
      begin
        user.update!(logincondition: false)
      rescue => e
        #何かしらエラーが起きたら、エラーログの書き込み ただし次のユーザーの処理へは進む
        logger.error "user_id: #{user.id}でエラーが発生"
        logger.error e
        logger.error e.backtrace.join("\n")
        next
      end
    end
  end
end