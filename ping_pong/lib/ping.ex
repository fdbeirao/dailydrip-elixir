defmodule Ping do
  def start do
    loop()
  end
  
  def loop do
    # receive pattern matches on a series of potential messages and runs some
    # code when it receives that message. Here we'll just send a message to the
    # pid we're sent.
    receive do
      { :pong, from } -> 
        IO.puts "ping ->"
        :timer.sleep 500
        send(from, { :ping, self() })
      { :ping, from } ->
        IO.puts "            <- pong"
        :timer.sleep 500
        send(from, { :pong, self() })
    end
    loop()
  end
end