ExUnit.start()

defmodule Client do
  def create_client() do
    NetsEasy.create_client(
      "http://bears.gov",
      "WITH_ARMS_WIDE_TOKAN",
      Tesla.Mock
    )
  end
end
