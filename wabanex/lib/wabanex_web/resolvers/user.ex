defmodule WabanexWeb.Resolvers.User do      #é meio de campo, recebe os parametros e executa as ações
  def get(%{id: user_id}, _context), do: Wabanex.Users.Get.call(user_id)

  def create(%{input: params}, _context), do: Wabanex.Users.Create.call(params)
end
