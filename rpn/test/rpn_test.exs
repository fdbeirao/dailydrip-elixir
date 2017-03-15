defmodule RpnTest do
  use ExUnit.Case
  #doctest Rpn

  test "starts with an empty stack" do
    {:ok, pid} = Rpn.start
    assert Rpn.peek(pid) == []
  end

  test "pushing onto the stack" do
    {:ok, pid} = Rpn.start
    Rpn.push(pid, 5)
    assert Rpn.peek(pid) == [5]
    Rpn.push(pid, 1)
    assert Rpn.peek(pid) == [1, 5]
  end

  test "adding" do
    {:ok, pid} = Rpn.start
    Rpn.push(pid, 5)
    Rpn.push(pid, 1)
    Rpn.push(pid, :+)
    assert Rpn.peek(pid) == [6]
  end

  test "subtracting" do
    {:ok, pid} = Rpn.start
    Rpn.push(pid, 5)
    Rpn.push(pid, 1)
    Rpn.push(pid, :-)
    assert Rpn.peek(pid) == [4]
  end

  test "multiplying" do
    {:ok, pid} = Rpn.start
    Rpn.push(pid, 5)
    Rpn.push(pid, 2)
    Rpn.push(pid, :x)
    assert Rpn.peek(pid) == [10]
  end

  test "wikipedia example" do
    {:ok, pid} = Rpn.start
    Rpn.push(pid, 5)
    Rpn.push(pid, 1)
    Rpn.push(pid, 2)
    Rpn.push(pid, :+)
    Rpn.push(pid, 4)
    Rpn.push(pid, :x)
    Rpn.push(pid, :+)
    Rpn.push(pid, 3)
    Rpn.push(pid, :-)
    assert Rpn.peek(pid) == [14]
  end
end
