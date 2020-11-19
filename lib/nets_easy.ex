defmodule NetsEasy do
  @moduledoc """
  Root module for creating clients.
  """

  @spec test_base_url :: String.t()
  def test_base_url, do: "TODO_URL"
  @spec live_base_url :: String.t()
  def live_base_url, do: "TODO_URL"

  @doc """
  Initializes a Tesla http client.
  Sets middlewares for base_url, authorization, user-agent: tesla and camelCase <> snake_case conversion
  as such these don't need to be included in additional_middleware

  adapter should be set to use a proper underlying http library, like mint or hackney

  By viewing this source it should be simple to create a custom tesla client.
  """
  @spec create_client(String.t(), String.t(), Tesla.Client.adapter(), [Tesla.Client.middleware()]) ::
          Tesla.Client.t()
  def create_client(base_url, secret_key, adapter, additional_middleware \\ []) do
    middleware =
      [
        {
          Tesla.Middleware.BaseUrl,
          base_url
        },
        {
          Tesla.Middleware.Headers,
          [
            {"user-agent", "Tesla"},
            {"authorization", "#{secret_key}"}
          ]
        },
        {Tesla.Middleware.JSON,
         decode: &NetsEasy.Middleware.JsonUtil.decode_and_snake_case/1,
         encode: &NetsEasy.Middleware.JsonUtil.encode_and_camelize/1}
      ] ++ additional_middleware

    Tesla.client(middleware, adapter)
  end

  @doc """
  Initializes a Tesla http client.

  This function reads parameters from config and calls &create_client/4
  """
  @spec create_client() :: Tesla.Client.t()
  def create_client() do
    [
      base_url: base_url,
      secret_key: secret_key,
      adapter: adapter,
      additional_middleware: am
    ] = Application.get_all_env(:nets_easy)

    additional_middleware =
      if is_nil(am) do
        []
      else
        am
      end

    create_client(base_url, secret_key, adapter, additional_middleware)
  end

  defmodule Api do
    @moduledoc """
    payment api methods, require a `Tesla.Env.client()`, see `NetsEasy.create_client/4`.
    """

    alias NetsEasy.Client.Helpers
    alias NetsEasy.Model

    @doc """
    Create a payment order, for displaying the payment menu view.
    """
    @spec create_payment_order(Tesla.Env.client(), Model.CreatePaymentRequest.t()) ::
            {:ok, Model.CreatePaymentResponse.t()}
            | {:error, Tesla.Env.t()}
            | {:error, {String.t(), Tesla.Env.t()}}
    def create_payment_order(client, request_body) do
      Tesla.post(
        client,
        "/v1/payments/",
        request_body
      )
      |> Helpers.evaluate_response(%{
        201 => %{
          decode_as: Model.CreatePaymentResponse.shell()
        }
      })
    end

    @doc """
    Get a payment order.
    """
    @spec get_payment_order(Tesla.Env.client(), String.t()) ::
            {:ok, Model.GetOrderResponse.t()}
            | {:error, Tesla.Env.t()}
            | {:error, {String.t(), Tesla.Env.t()}}
    def get_payment_order(client, payment_id) do
      Tesla.get(
        client,
        "/v1/payments/#{payment_id}"
      )
      |> Helpers.evaluate_response(%{
        200 => %{
          decode_as: Model.GetOrderResponse.shell()
        }
      })
    end

    @doc """
    Charge a payment.
    """
    @spec charge_payment(Tesla.Env.client(), String.t(), Model.ChargePaymentRequest.t()) ::
            {:ok, Model.ChargePaymentResponse.t()}
            | {:error, Tesla.Env.t()}
            | {:error, {String.t(), Tesla.Env.t()}}
    def charge_payment(client, payment_id, request_body) do
      Tesla.post(
        client,
        "/v1/payments/#{payment_id}/charges",
        request_body
      )
      |> Helpers.evaluate_response(%{
        201 => %{
          decode_as: Model.ChargePaymentResponse.shell()
        }
      })
    end

    @doc """
    Refund a charge
    """
    @spec refund_payment(Tesla.Env.client(), String.t(), Model.RefundPaymentRequest.t()) ::
            {:ok, Model.RefundPaymentResponse.t()}
            | {:error, Tesla.Env.t()}
            | {:error, {String.t(), Tesla.Env.t()}}
    def refund_payment(client, charge_id, request_body) do
      Tesla.post(
        client,
        "/v1/charges/#{charge_id}/refunds",
        request_body
      )
      |> Helpers.evaluate_response(%{
        200 => %{
          decode_as: Model.RefundPaymentResponse.shell()
        }
      })
    end
  end
end
