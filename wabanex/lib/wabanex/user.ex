defmodule Wabanex.User do
  # importa macro e qualquer tipo de código
  use Ecto.Schema
  alias Wabanex.Training
  # importa funções   #defina como dados são alterados, deve ser configurado
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  # constante que só existe nesse modulo
  @fields [:email, :password, :name]

  schema "users" do
    field :email, :string
    field :name, :string
    # definição tamanho?
    field :password, :string

    #has_one :training, Training
    has_many :trainings, Training

    timestamps()
  end

  def changeset(params) do
    # %Wabanex.User{            #Create.call(params)
    %__MODULE__{}
    # função do Ecto.Changeset
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end

# Repo é parte do Ecto
# Ecto é lógica
# Repo é mais bd

# mix deps.get

#mix compile

#criar tabela
#mix ecto.gen.migration create_trainings_table

#mix ecto.migrate

#Repo.all(User)
#Repo.all(User) |> Repo.preload([:training])
# User |> Repo.all() |> Repo.preload([:trainings])
