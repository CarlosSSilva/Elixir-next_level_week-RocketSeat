defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Accounts

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Accounts{} = account} <- Rocketpay.deposity(params) do
      conn
      |> put_status(:ok)
      |> render("upddate.json", account: account)
    end
  end
end
