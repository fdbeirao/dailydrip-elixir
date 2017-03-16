defmodule AgentTaskSupervisionPlaygroundTest do
  use ExUnit.Case

  test "regular tasks do not outlive their spawner" do
    pid = self()
    spawn(fn() ->
      Task.start_link(fn() -> 
        :timer.sleep 50
        send(pid, :sup)
      end)
      Process.exit(self(), :kill)
    end)
    :timer.sleep 60
    refute_receive :sup
  end

  test "tasks that outlive their spawner" do
    pid = self()
    spawn(fn() -> 
      Task.Supervisor.start_child(OurSupervisor, fn() -> 
        :timer.sleep 50
        send(pid, :sup)
      end)
      Process.exit(self(), :kill)
    end)
    :timer.sleep 60
    assert_receive :sup
  end

  alias AgentTaskSupervisionPlayground.Bucket

  test "working with an agent" do
    Bucket.push(OurBucket, :foo)
    assert :foo = Bucket.head(OurBucket)
  end

end
