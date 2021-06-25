defmodule Wabanex.Users.Create do
  alias Wabanex.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end

# Repo.get(User, "id de usuario ja inserido") -> devolve o usuário, se não existir, devolve nulo
