defmodule Calendlex.EventType do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields ~w(name slug duration color)a
  @optional_fields ~w(description deleted_at)a

  schema "event_types" do
    field :description, :string
    field :duration, :integer
    field :name, :string
    field :slug, :string
    field :color, :string
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(event_type \\ %EventType{}, attrs) do
    event_type
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> build_slug()
    |> validate_required(@required_fields)
    |> unique_constraint(:slug, name: "event_types_slug_index")
  end

  def delete_changeset(%EventType{} = event_type) do
    event_type
    |> with_deleted_changes()
    |> validate_required(@required_fields)
  end

  defp with_deleted_changes(%{name: name, slug: slug} = event_type) do
    event_type
    |> change()
    |> put_change(:name, "#{name} (deleted)")
    |> put_change(:slug, "#{slug}-deleted-#{:os.system_time(:millisecond)}")
    |> put_change(:deleted_at, DateTime.truncate(DateTime.utc_now(), :second))
  end

  def build_slug(%{changes: %{name: name}} = changeset) do
    put_change(changeset, :slug, Slug.slugify(name))
  end

  def build_slug(changeset), do: changeset
end
