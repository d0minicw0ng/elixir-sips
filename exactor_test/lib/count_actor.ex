defmodule CountActor do
  use ExActor.GenServer

  defstart start, do: initial_state(1)

  defcall get, state: 2, do: reply(:two)
  defcall get, state: state , do: reply(state)

  defcast inc, state: state , do: new_state(state + 1)
  defcast dec, state: state , do: new_state(state - 1)
end
