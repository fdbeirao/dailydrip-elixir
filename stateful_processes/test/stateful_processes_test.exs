defmodule StatefulProcessesTest do
  use ExUnit.Case
  doctest StatefulProcesses

  test "starting the counter" do
    {:ok, pid} = Counter.start(0)
    assert is_pid(pid)
  end

  test "getting the value" do
    {:ok, pid} = Counter.start(0)
    assert {:ok, 0} = Counter.get_value(pid)
  end

  test "incrementing the value" do
    {:ok, pid} = Counter.start(0)
    :ok = Counter.increment(pid)
    assert {:ok, 1} = Counter.get_value(pid)
  end

  test "decrementing the value" do
    {:ok, pid} = Counter.start(0)
    :ok = Counter.decrement(pid)
    assert {:ok, -1} = Counter.get_value(pid)
  end
end
