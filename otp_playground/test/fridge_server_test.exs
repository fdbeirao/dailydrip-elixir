defmodule OtpPlayground.FridgeServerTest do
  use ExUnit.Case
  alias OtpPlayground.FridgeServer

  test "putting something into the fridge" do
    { :ok, fridge } = FridgeServer.start_link
    assert :ok == FridgeServer.store(fridge, :bacon)
  end

  test "removing something from the fridge" do
    { :ok, fridge } = FridgeServer.start_link
    FridgeServer.store(fridge, :bacon)
    assert {:ok, :bacon} == FridgeServer.take(fridge, :bacon)
  end

  test "taking something from the fridge that isn't in there" do
    { :ok, fridge } = FridgeServer.start_link
    assert :not_found == FridgeServer.take(fridge, :bacon)
  end
end
