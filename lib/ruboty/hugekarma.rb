require 'ruboty'
require 'ruboty/hugekarma/version'
require 'japanese_numbers'

module Ruboty
  module Handlers
    class HugeKarma < Base
      BRAIN_KEY = 'hugekarma'

      on(
        /(?<name>.+)\+\+$/,
        name: 'increment',
        description: "Increment <name>'s karma by 1",
        all: true
      )

      on(
        /(?<name>.+) \+(?<value>[\d万億兆京]+)$/,
        name: 'super_increment',
        description: "Increment <name>'s score by specified value",
        all: true
      )

      on(
        /karma list$/,
        name: 'list_karma',
        description: "Show karma ranking"
      )

      def increment(message)
        brain = message.robot.brain
        data = brain.data[BRAIN_KEY] || {}
        data[message[:name]] ||= 0
        data[message[:name]] += 1
        brain.data[BRAIN_KEY] = data

        message.reply("Incremented #{message[:name]}'s karma (current: #{data[message[:name]]})")
      end

      def super_increment(message)
        incr_value = JapaneseNumbers::Parser.parse(message[:value])

        brain = message.robot.brain
        data = brain.data[BRAIN_KEY] || {}
        data[message[:name]] ||= 0
        data[message[:name]] += incr_value
        brain.data[BRAIN_KEY] = data

        message.reply("Incremented #{message[:name]}'s karma by #{incr_value} (current: #{data[message[:name]]})")
      end

      def list_karma(message)
        brain = message.robot.brain
        data = brain.data[BRAIN_KEY] || {}
        sorted = data.sort_by {|name, karma| karma}.reverse

        reply = sorted.map {|d| "#{d[0]}: #{d[1]}"}
        message.reply(reply.join("\n"))
      end
    end
  end
end
