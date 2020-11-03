defmodule NetsEasy.Model.GetOrderResponse.Company do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .consumer.company
  """
  @type t :: %__MODULE__{
          merchant_reference: String.t(),
          name: String.t(),
          registration_number: String.t(),
          contact_details: Model.GetOrderResponse.ContactDetails.t()
        }

  @derive Poison.Encoder
  defstruct [
    :merchant_reference,
    :name,
    :registration_number,
    :contact_details
  ]

  @doc false
  def shell() do
    %__MODULE__{
      contact_details: Model.GetOrderResponse.ContactDetails.shell()
    }
  end
end
