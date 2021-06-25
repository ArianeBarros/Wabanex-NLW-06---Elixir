defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Rafael", email: "rafael@gmail.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{name: "Rafael", email: "rafael@gmail.com", password: "123456"},
        errors: []
      } = response  #não é == pq usa pattern match
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "R", email: "rafael@gmail.com"}

      response = User.changeset(params)

      assert errors_on(response) ==  %{name: ["should be at least 2 character(s)"], password: ["can't be blank"]}
    end
  end
end
