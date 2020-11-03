defmodule NetsEasy.Model.GetOrderResponse.PaymentDetails do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .payment_details
  """
  @type t :: %__MODULE__{
          card_details: Model.GetOrderResponse.CardDetails.t(),
          invoice_details: Model.GetOrderResponse.InvoiceDetails.t(),
          payment_method: String.t(),
          payment_type: String.t()
        }

  @derive Poison.Encoder
  defstruct [
    :card_details,
    :invoice_details,
    :payment_method,
    :payment_type
  ]

  @doc false
  def shell() do
    %__MODULE__{
      card_details: Model.GetOrderResponse.CardDetails.shell(),
      invoice_details: Model.GetOrderResponse.InvoiceDetails.shell()
    }
  end
end
