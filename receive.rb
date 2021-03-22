require 'bunny'

# cria conexão com o RabbitMQ através do Bunny
connection = Bunny.new(automatically_recover: false)
connection.start

# Abre um novo canal AMQP 0.9.1
channel = connection.create_channel
# Declara a queue para o canal que foi aberto para garantir que o canal exista
queue = channel.queue('hello')

begin
  puts '[*] Waiting for messages. To exit press CTRL+C'
  # coloca a queue consumir as mensagens da fila
  queue.subscribe(block: true) do |_delivery_info, _properties, body |
    puts "[X] Received #{body}"
  end
rescue Interrupt => _
  connection.close
  # fecha a conexao
  exit(0)
end
