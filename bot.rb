require 'telegram/bot'
require './wunderlist_wrapper'

token = '589796906:AAGIhBK9efRirSD5QL3QmjSd0-nvn3ZxqWM'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    tasks = message.text.split("\n")
    if tasks.size.positive?
      wl = Wishwundergram::WunderlistWrapper.new(tasks)
      wl.create_list
      wl.create_tasks
      bot.api.send_message(chat_id: message.chat.id, text: 'Done!')
    end
  end
end
