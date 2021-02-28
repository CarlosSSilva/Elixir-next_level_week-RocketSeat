defmodule  RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true #para teste de controle

  alias Rocketpay.{Accounts, User}

  describe "deposit/2"do
    setup %{conn: conn} do
      params = %{
        name: "Correa",
        password: "654321",
        nickname: "Correa",
        email: "carloscorrea@gmail.com",
        age: 20
      }

      {:ok, %User{account: %Accounts{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic Q2FybG9zOmdyYW5kZTEyMw==") #autenticação do test
      #como em Header no insominia

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
       conn
       |> post(Routes.accounts_path(conn, :deposit, account_id, params))
       |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id },
        "message" => "Ballance Changed successfully"
        } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "Fill"}

      response =
       conn
       |> post(Routes.accounts_path(conn, :deposit, account_id, params))
       |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value!"}

      assert response == expected_response
    end
  end
end
