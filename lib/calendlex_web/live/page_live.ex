defmodule CalendlexWeb.PageLive do
  use CalendlexWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end