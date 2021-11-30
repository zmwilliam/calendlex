defmodule Calendlex.EventType.Repo do
  import Ecto.Query, only: [order_by: 3]

  alias Calendlex.EventType
  alias Calendlex.Repo

  def available do
    EventType
    |> order_by([e], e.name)
    |> Repo.all()
  end
end
