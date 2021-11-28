defmodule Calendlex.EventType do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields ~w(name slug duration color)a
  @optional_fields ~w(description)a

  schema "event_types" do
    field :description, :string
    field :duration, :integer
    field :name, :string
    field :slug, :string
    field :color, :string

    timestamps()
  end

  @doc false
  def changeset(event_type \\ %EventType{}, attrs) do
    event_type
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:slug, name: "event_type_sluyg_index")
  end
end
