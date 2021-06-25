defmodule Wabanex.Exercise do
  # importa macro e qualquer tipo de código
  use Ecto.Schema

  alias Wabanex.{Training}
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  # constante que só existe nesse modulo
  @fields [:name, :protocol_description, :repetitions, :youtube_video_url]

  schema "exercises" do
    field :name, :string
    field :protocol_description, :string
    field :repetitions, :string
    field :youtube_video_url, :string

    belongs_to :training, Training

    timestamps()
  end

  def changeset(exercise, params) do
   exercise
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
