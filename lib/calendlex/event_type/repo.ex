defmodule Calendlex.EventType.Repo do
  import Ecto.Query, only: [order_by: 3, where: 3]

  alias Calendlex.EventType
  alias Calendlex.Repo

  def available do
    EventType
    |> where([e], is_nil(e.deleted_at))
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

  def clone(%EventType{name: name} = event_type) do
    event_type
    |> Map.from_struct()
    |> Map.put(:name, "#{name} (clone)")
    |> insert()
  end

  def delete(%EventType{} = event_type) do
    event_type
    |> EventType.delete_changeset()
    |> Repo.update()
  end
end
