defmodule WithExampleTest do
  use ExUnit.Case

  # Examples taken from http://learningelixir.joekain.com/learning-elixir-with/

  test "`with` normal usage" do
    opts = %{width: 10, height: 15}
    assert {:ok, 150} ==
      with {:ok, width} <- Map.fetch(opts, :width),
           {:ok, height} <- Map.fetch(opts, :height),
       do: {:ok, width * height}
  end

  test "`with` returns the right hand side of the first pattern match fail" do
    opts = %{width: 10}
    assert :error ==
      with {:ok, width} <- Map.fetch(opts, :width),
           {:ok, height} <- Map.fetch(opts, :height),
       do: {:ok, width * height}
  end

  test "`with` returns right hand side of failing pattern match" do
    assert :right ==
      with {:ok, _} <- :right,
       do: :error
  end

  test "`with` has its own scope" do
    width = nil
    opts = %{width: 10, height: 15}
    assert {:ok, 300} ==
      with {:ok, width} <- Map.fetch(opts, :width),
        double_width = width * 2,
        {:ok, height} <- Map.fetch(opts, :height),
       do: {:ok, double_width * height}
    assert width == nil
  end
end
