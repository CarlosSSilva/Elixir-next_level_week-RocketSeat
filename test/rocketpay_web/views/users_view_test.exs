defmodule  RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true #para testes de view

  import Phoenix.View #para render de view

  alias RocketpayWeb.UsersView
  alias Rocketpay.{Accounts,User}

  test "renders create.json" do
    params = %{
      name: "Correa",
      password: "654321",
      nickname: "Correa",
      email: "carloscorrea@gmail.com",
      age: 20
    }

    {:ok, %User{id: user_id, account: %Accounts{id: account_id}} = user } =
      Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)
# uso de decimal
    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Correa",
        nickname: "Correa"
      }
    }

    assert expected_response == response
  end
end
