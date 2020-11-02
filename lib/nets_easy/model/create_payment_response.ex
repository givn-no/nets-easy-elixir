defmodule NetsEasy.Model.CreatePaymentResponse do
  @moduledoc """
  """

  @typedoc """
  Root response for creating a payment request.

  See https: //tech.dibspayment.com/easy/api/paymentapi
  """
  @type t :: %__MODULE__{
          payment_id: String.t()
        }

  @derive Poison.Encoder
  defstruct [
    :payment_id
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
