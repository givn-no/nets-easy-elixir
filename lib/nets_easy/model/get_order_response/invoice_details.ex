defmodule NetsEasy.Model.GetOrderResponse.InvoiceDetails do
  @moduledoc """
  """

  @typedoc """
  .invoice_details.invoice_details
  """
  @type t :: %__MODULE__{
          due_date: String.t(),
          invoice_number: String.t(),
          ocr: String.t(),
          pdf_link: String.t()
        }

  @derive Poison.Encoder
  defstruct [
    :due_date,
    :invoice_number,
    :ocr,
    :pdf_link
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
