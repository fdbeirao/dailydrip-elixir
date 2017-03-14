defmodule PingPongTest do
  use ExUnit.Case
  doctest PingPong

  test "it responds to a pong with a ping" do
    # spawn takes a module, a function name, and a list of arguments
    # It starts a new process, running that function. When the function
    # completes, the new process will die
    ping = spawn(Ping, :start, [])
    # send lets you send messages to a process
    # self provides the current process's PID, or Process ID
    send(ping, {:pong, self()})
    # We'll assert that when we send a pong to a process, we receive back a ping
    # This waits for up to 100ms and passes if the message is received in that
    # time frame, failing if it isn't.
    assert_receive {:ping, ^ping}
  end

  test "it responds to two messages" do
    ping = spawn(Ping, :start, [])
    send(ping, {:pong, self()})
    assert_receive {:ping, ^ping}
    send(ping, {:pong, self()})
    assert_receive {:ping, ^ping}
  end
end
