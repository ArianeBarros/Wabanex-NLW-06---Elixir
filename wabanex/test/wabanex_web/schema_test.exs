defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.{User, Users.Create}

  describe "users queries" do
    test "when a valid id is given, returns user", %{conn: conn} do
      params = %{email: "arianepb@gmail.com", name: "Ariane", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            email
            name
          }
        }
      """
        response =
          conn
          |> post("/api/graphql", %{query: query})
          |> json_response(:ok)  #(200)

        expected_response =
          %{
            "data" => %{
              "getUser" => %{
                "email" => "arianepb@gmail.com",
                "name" => "Ariane"
              }
            }
          }

        assert expected_response == response
    end

    test "when an invalid id is given, returns error", %{conn: conn} do
      params = %{email: "arianepb+errortest@gmail.com", name: "Ariane", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "cfb6b7b0-dafa-4f79-9791-67d6f6eace1d"){
            email
            name
          }
        }
      """
      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)  #(200)

      expected_response =
        %{"data" => %{"getUser" => nil}, "errors" => [%{"locations" => [%{"column" => 5, "line" => 2}], "message" => "User not found", "path" => ["getUser"]}]}

      assert expected_response == response
    end

    test "when all params are valid, creates user", %{conn: conn} do
      mutation = """
      mutation {
        createUser(input: {name: "João", email: "joao@gmail.com", password: "1235434"}){
          id
          name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "João"}}} = response
    end
  end
end


#desafios
#criar uma migration para adicionar novos campos (alter)
#criar mutation para alterar e deletar
#cobrir todos os testes restantes (mix test --cover) -> ler lib do excoveralls:  https://github.com/parroty/excoveralls
