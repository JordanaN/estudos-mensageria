# encoding: utf-8

require 'bunny'

# cria conexão com o RabbitMQ através do Bunny
connection = Bunny.new(automatically_recover: false)
connection.start

# Abre um novo canal AMQP 0.9.1
channel = connection.create_channel

# Declara a queue para o canal que foi aberto
queue = channel.queue('hello')
# instancia uma troca de mensagem e publica a mensagem passando o rounting_key no nome da queue
channel.default_exchange.publish('Hello World', routing_key: queue.name)
puts "[x] Sent 'Hello World!'"
# fecha conexao
connection.close

