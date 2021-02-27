defmodule Rocketpay.Users.Create do
  alias Ecto.Multi
  alias Rocketpay.{Accounts, Repo, User}

  def call(params) do
    #criando conta e usuario ao mesmo tempo
    Multi.new() #prepara o ambiente but nao execulta
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      insert_account(repo, user)
  end)
  |> Multi.run(:preload_data, fn repo, %{create_user: user} ->
    preload_data(repo, user)
  end)
  |> run_transaction()
end

#execulta e cria usuario com contas
  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: "0.00"}

    Accounts.changeset(params)
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi)do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
