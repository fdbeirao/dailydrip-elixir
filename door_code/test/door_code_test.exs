defmodule Door do
  use GenStateMachine

  ### Client API
  def start_link({code, remaining, unlock_time}), do:
    GenStateMachine.start_link(Door, {:locked, {code, remaining, unlock_time}})
  
  def get_state(pid), do:
    GenStateMachine.call(pid, :get_state)
  
  def press(pid, digit), do:
    GenStateMachine.cast(pid, {:press, digit})

  ### Server API
  def handle_event({:call, from}, :get_state, state, data), do:
    {:next_state, state, data, [{:reply, from, state}]}

  def handle_event(:cast, {:press, digit}, :locked, {code, remaining, unlock_time}) do
    case remaining do
      [digit] ->
        IO.puts "[#{digit}] Correct code. Unlocked for #{unlock_time}"
        {:next_state, :open, {code, code, unlock_time}, unlock_time}
      [digit|rest] ->
        IO.puts "[#{digit}] Correct digit but not yet complete."
        {:next_state, :locked, {code, rest, unlock_time}}
      _ ->
        IO.puts "[#{digit}] Wrong digit, locking."
        {:next_state, :locked, {code, code, unlock_time}}
    end
  end

  def handle_event(:timeout, _, _, data) do
    IO.puts "timeout expired, locking door"
    {:next_state, :locked, data}
  end

end

defmodule DoorCodeTest do
  use ExUnit.Case

  @code [1, 2, 3]
  @open_time 100
  
  test "happy path" do
    {:ok, door} = Door.start_link({@code, @code, @open_time})
    assert Door.get_state(door) == :locked
    door |> Door.press(1)
    assert Door.get_state(door) == :locked
    door |> Door.press(2)
    assert Door.get_state(door) == :locked
    door |> Door.press(3)
    assert Door.get_state(door) == :open
    :timer.sleep(@open_time)
    assert Door.get_state(door) == :locked
  end

end
