defmodule Calendlex.EventType.Repo do
  import Ecto.Query, only: [order_by: 3]

  alias Calendlex.EventType
  alias Calendlex.Repo

  def available do
    EventType
    |> order_by([e], e.name)
    |> Repo.all()
  end

  def get(id) do
    case Repo.get(EventType, id) do
      nil -> {:error, :not_found}
      event_type -> {:ok, event_type}
    end
  end

  def get_by_slug(slug) do
    case Repo.get_by(EventType, slug: slug) do
      nil -> {:error, :not_found}
      event_type -> {:ok, event_type}
    end
  end

  def insert(attrs) do
    attrs
    |> EventType.changeset()
    |> Repo.insert()
  end

  def update(%EventType{} = event_type, attrs) do
    event_type
    |> EventType.changeset(attrs)
    |> Repo.update()
  end
end
