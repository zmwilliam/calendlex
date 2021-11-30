defmodule CalendlexWeb.EventTypeLive do
  use CalendlexWeb, :live_view

  alias CalendlexWeb.Components.EventType

  def mount(%{"event_type_slug" => slug}, _session, socket) do
    case Calendlex.get_event_type_by_slug(slug) do
      {:ok, event_type} ->
        socket =
          socket
          |> assign(event_type: event_type)
          |> assign(page_title: event_type.name)

        {:ok, socket}

      {:error, :not_found} ->
        {:ok, socket, layout: {CalendlexWeb.LayoutView, "not_found.html"}}
    end
  end

  def handle_params(params, _uri, socket) do
    socket = assign_dates(socket, params)

    {:noreply, socket}
  end

  defp assign_dates(%{assigns: %{time_zone: timezone}} = socket, params) do
    current = current_from_params(timezone, params)
    beginning_of_month = Timex.beginning_of_month(current)
    end_of_month = Timex.end_of_month(current)

    previous_month =
      beginning_of_month
      |> Timex.add(Timex.Duration.from_days(-1))
      |> date_to_month()

    next_month =
      end_of_month
      |> Timex.add(Timex.Duration.from_days(1))
      |> date_to_month()

    socket
    |> assign(current: current)
    |> assign(beginning_of_month: beginning_of_month)
    |> assign(end_of_month: end_of_month)
    |> assign(previous_month: previous_month)
    |> assign(next_month: next_month)
  end

  defp date_to_month(date_time), do: Timex.format!(date_time, "{YYYY}-{0M}")

  defp current_from_params(timezone, %{"month" => month}) do
    case Timex.parse("#{month}-01", "{YYYY}-{0M}-{D}") do
      {:ok, current} -> NaiveDateTime.to_date(current)
      _ -> Timex.today(timezone)
    end
  end

  defp current_from_params(timezone, %{"date" => date}) do
    case Timex.parse(date, "{YYYY}-{0M}-{D}") do
      {:ok, current} -> NaiveDateTime.to_date(current)
      _ -> Timex.today(timezone)
    end
  end

  defp current_from_params(timezone, _), do: Timex.today(timezone)
end
