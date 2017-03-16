defmodule AgentTaskSupervisionPlayground.Application do
  @moduledoc false

  use Application

  alias AgentTaskSupervisionPlayground.Bucket

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Task.Supervisor, [[name: OurSupervisor]]),
      worker(Bucket, [OurBucket])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AgentTaskSupervisionPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
