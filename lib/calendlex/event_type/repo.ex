defmodule Calendlex.EventType.Repo do
  import Ecto.Query, only: [order_by: 3]

  alias Calendlex.EventType
  alias Calendlex.Repo

  def available do
    EventType
    |> order_by([e], e.name)
    |> Repo.all()
  end

  def get_by_slug(slug) do
    case Repo.get_by(EventType, slug: slug) do
      nil -> {:error, :not_found}
      event_type -> {:ok, event_type}
    end
  end
end
