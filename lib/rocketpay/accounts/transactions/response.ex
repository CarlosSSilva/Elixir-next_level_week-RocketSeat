defmodule Rocketpay.Accounts.Transaction.Response do
  alias Rocketpay.Accounts

  defstruct [:from_account, :to_account]

  def build(%Accounts{} = from_account, %Accounts{} = to_account) do
    %__MODULE__{
      from_account: from_account,
      to_account: to_account
    }

  end

end
