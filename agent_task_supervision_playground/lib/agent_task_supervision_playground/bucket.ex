defmodule AgentTaskSupervisionPlayground.Bucket do
  def start_link(name), do:
    Agent.start_link(fn() -> [] end, [name: name])

  def push(pid, item), do:
    Agent.update(pid, fn(state) -> [item|state] end)
  
  def head(pid), do:
    Agent.get(pid, fn(state) -> hd(state) end)

end