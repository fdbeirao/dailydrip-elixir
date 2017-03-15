defmodule Rpn do
  @moduledoc """
  A Reverse Polish calculator
  """

  defmacro applyOperationToState(operation) do
    quote do: fn(state) -> runOperation(state, unquote(operation)) end
  end

  def start(), do: 
    Agent.start(fn -> [] end)

  def peek(agentPid), do:
    Agent.get(agentPid, fn(value) -> value end)

  def push(agentPid, :+), do:
    Agent.update(agentPid, applyOperationToState(&+/2))

  def push(agentPid, :-), do:
    Agent.update(agentPid, applyOperationToState(&-/2))

  def push(agentPid, :x), do:
    Agent.update(agentPid, applyOperationToState(&*/2))

  def push(agentPid, number) when is_integer(number), do:
    Agent.update(agentPid, fn(state) -> [number | state] end)

  defp runOperation([value2,value1|tail], operation), do:
    [operation.(value1, value2) | tail]

end
