defmodule Calendlex.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias Calendlex.EventType

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields ~w(start_at end_at name email time_zone)a
  @optional_fields ~w(event_type_id comments)a

  schema "events" do
    field :comments, :string
    field :email, :string
    field :name, :string
    field :time_zone, :string
    field :start_at, :utc_datetime
    field :end_at, :utc_datetime

    belongs_to :event_type, EventType

    timestamps()
  end

  @doc false
  def changeset(event \\ %Event{}, attrs) do
    event
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
