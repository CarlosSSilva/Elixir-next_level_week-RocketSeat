defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true#sandnox em ambientes de test

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "whe all params are valid, returns an user" do
      params = %{
        name: "Correa",
        password: "654321",
        nickname: "Correa",
        email: "carloscorrea@gmail.com",
        age: 20
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{
        name: "Correa",
        age: 20,
        id: ^user_id} = user #^ pin operator - fixa o valor
      end

        test "whe there are invalid params, returns an error" do
          params = %{
            name: "Correa",
            nickname: "Correa",
            email: "carloscorrea@gmail.com",
            age: 15
          }
      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
