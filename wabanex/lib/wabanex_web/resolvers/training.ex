defmodule WabanexWeb.Resolvers.Training do      #é meio de campo, recebe os parametros e executa as ações
  def create(%{input: params}, _context), do: Wabanex.Trainings.Create.call(params)
end
