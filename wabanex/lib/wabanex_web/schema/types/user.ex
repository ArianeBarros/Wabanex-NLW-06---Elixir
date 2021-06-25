defmodule WabanexWeb.Schema.Types.User do
  use Absinthe.Schema.Notation


  @desc "Logic user representation"
  object :user do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :trainings, list_of(:training)  #refatorar para não devolver uma lista
  end

  input_object :create_user_input do    #objeto para validação que representa a entrada de dados (quais dados recebemos na mutatio)
    field :name, non_null(:string), description: "Users name"
    field :email, non_null(:string), description: "Users email"
    field :password, non_null(:string), description: "Users password"
  end
end
