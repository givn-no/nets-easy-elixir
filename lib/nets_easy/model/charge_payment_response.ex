defmodule NetsEasy.Model.ChargePaymentResponse do
  @moduledoc """
  """

  @typedoc """
  Root response for charging a payment.

  See https://tech.dibspayment.com/easy/api/paymentapi#chargePayment
  """
  @type t :: %__MODULE__{
          charge_id: String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :charge_id
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
