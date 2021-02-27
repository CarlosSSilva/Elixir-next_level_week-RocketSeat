defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Accounts
  alias Rocketpay.Accounts.Transaction.Response, as: TransactionResponse

  def render("update.json", %{
    account: %Accounts{id: account_id, balance: balance}}) do
    %{
      message: "Ballance Changed successfully",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("transaction.json", %{
    transaction: %TransactionResponse{to_account: to_account, from_account: from_account}}) do
    %{
      message: "Transaction Done successfully",
      transaction: %{
        from_account: %{
          id: from_account.id,
          balance: from_account.balance
        },
        to_account: %{
          id: to_account.id,
          balance: to_account.balance
        }
      }
    }
  end
end
