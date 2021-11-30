defmodule CalendlexWeb.EventTypeLive do
  use CalendlexWeb, :live_view

  def mount(%{"event_type_slug" => _slug} = _params, _session, socket) do
    {:ok, socket}
  end
end