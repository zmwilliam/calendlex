defmodule CalendlexWeb.Admin.EventTypesLive do
  use CalendlexWeb, :admin_live_view

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [event_types: []]}
  end

  def handle_params(_params, _uri, socket) do
    event_types = Calendlex.available_event_types()

    {:noreply,
     socket
     |> assign(section: "event_types")
     |> assign(page_title: "Event types")
     |> assign(event_types: event_types)
     |> assign(event_types_count: length(event_types))}
  end
end
