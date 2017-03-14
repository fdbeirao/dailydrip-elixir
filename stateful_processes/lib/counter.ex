defmodule Counter do
  def start(initial_value) do
    Agent.start(fn -> initial_value end)
  end

  def get_value(agentPid) do
    Agent.get(agentPid, fn(value) -> {:ok, value} end)
  end

  def increment(agentPid) do
    Agent.update(agentPid, fn(value) -> value + 1 end)
  end

  def decrement(agentPid) do
    Agent.update(agentPid, fn(value) -> value - 1 end)
  end
end