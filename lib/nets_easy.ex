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
    %{
      base_url: base_url,
      secret_key: secret_key,
      adapter: adapter,
      additional_middleware: am
    } = Application.get_env(:nets_easy, NetsEasy)

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
  end
end
