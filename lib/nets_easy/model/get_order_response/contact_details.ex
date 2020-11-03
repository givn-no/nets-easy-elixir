defmodule NetsEasy.Model.GetOrderResponse.ContactDetails do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .consumer.company.contact_details
  """
  @type t :: %__MODULE__{
          first_name: String.t(),
          last_name: String.t(),
          email: String.t(),
          phone_number: Model.PhoneNumber.t()
        }

  @derive Poison.Encoder
  defstruct [
    :first_name,
    :last_name,
    :email,
    :phone_number
  ]

  @doc false
  def shell() do
    %__MODULE__{
      phone_number: Model.PhoneNumber.shell()
    }
  end
end
