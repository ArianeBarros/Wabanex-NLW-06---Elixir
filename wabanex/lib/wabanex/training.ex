defmodule Wabanex.Training do
  # importa macro e qualquer tipo de código
  use Ecto.Schema

  alias Wabanex.{Exercise, User}
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  # constante que só existe nesse modulo
  @fields [:end_date, :start_date, :user_id]

  schema "trainings" do
    field :end_date, :date
    field :start_date, :date

    belongs_to :user, User
    has_many :exercises, Exercise

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint([:email])
    |> cast_assoc(:exercises)
  end
end
