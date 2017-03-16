defmodule Rpn do
  @moduledoc """
  A Reverse Polish calculator
  """

  defp apply_operation(pid, operation) do
    Agent.update(pid, fn(state) -> run_operation(state, operation) end)
  end

  def start(), do:
    Agent.start(fn -> [] end)

  def peek(pid), do:
    Agent.get(pid, fn(value) -> value end)

  def push(pid, :+), do:
    apply_operation(pid, &+/2)

  def push(pid, :-), do:
    apply_operation(pid, &-/2)

  def push(pid, :x), do:
    apply_operation(pid, &*/2)

  def push(pid, number) when is_integer(number), do:
    Agent.update(pid, fn(state) -> [number | state] end)

  defp run_operation([value2, value1|tail], operation), do:
    [operation.(value1, value2) | tail]

end
