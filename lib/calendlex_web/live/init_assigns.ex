defmodule CalendlexWeb.Live.InitAssigns do
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    owner = Application.get_env(:calendlex, :owner)
    time_zone = get_connect_params(socket)["timezone"] || owner.time_zone

    {
      :cont,
      socket
      |> assign(:owner, owner)
      |> assign(:time_zone, time_zone)
    }
  end

  def on_mount(:private, _params, _session, socket) do
    owner = Application.get_env(:calendlex, :owner)

    {:cont, assign(socket, :owner, owner)}
  end
end
