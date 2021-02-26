defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  action_fallback RocketpayWeb.FallbackController
  #e o fallback recebe o erro
  def create(conn, params) do #with devolve erros casso nao der match
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn #onde verifica um caso
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
