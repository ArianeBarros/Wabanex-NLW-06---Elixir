defmodule Wabanex.IMC do
  def calculate(%{"filename" => filename}) do   #%{"filename" => filename}
    filename
    |> File.read()
    |> handle_file()

    # result = File.read(filename)
    # handle_file(result)
  end

  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split(~r{\r\n|\r|\n})
      |> Enum.map(fn line -> parse_line(line) end)
      |> Enum.into(%{})

    {:ok, data}
  end

  defp handle_file({:error, _reason}) do
    # reason
    {:error, "Error while opening the file"}
  end

  # defp handle_file(_) do
  #  "Exceção lançada"
  # end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
    |> IO.inspect()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end

# recompile
# Wabanex.IMC.calculate("students.csv")
# iex -S  mix
# mix ecto.setup
# mix phx.server

# schema faz validações
# Repo insere
