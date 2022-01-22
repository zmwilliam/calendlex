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
    |> build_slug()
    |> validate_required(@required_fields)
    |> unique_constraint(:slug, name: "event_type_slug_index")
  end

  def build_slug(%{changes: %{name: name}} = changeset) do
    put_change(changeset, :slug, Slug.slugify(name))
  end

  def build_slug(changeset), do: changeset
end
