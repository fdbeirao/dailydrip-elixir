defmodule CounterManualServer do
  def start(initial_value) do
    {:ok, spawn(Counter, :loop, [initial_value])}
  end

  def get_value(server_pid) do
    ref = make_ref()
    send(server_pid, {self(), ref, :get_value})

    receive do 
      {:ok, ^ref, value} -> {:ok, value}
    end
  end

  def increment(pid) do
    send(pid, :increment)
    :ok
  end

  def decrement(pid) do
    send(pid, :decrement)
    :ok
  end

  def loop(value) do
    receive do
      {from, ref, :get_value} -> 
        send(from, {:ok, ref, value})
        loop(value)
      :increment ->
        loop(value + 1)
      :decrement ->
        loop(value - 1)
    end
  end
end