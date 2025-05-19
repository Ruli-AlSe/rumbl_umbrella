defmodule Rumbl.TestHelpers do
  alias Rumbl.{ Accounts, Multimedia }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
          name: "Some user",
          username: "user#{System.unique_integer([:positive])}",
          password: attrs[:password] || "secret_password",
        })
      |>Accounts.register_user()

      user
  end

  def video_fixture(%Accounts.User{} = user, attrs \\ %{}) do
      attrs =
        Enum.into(attrs, %{
          title: "Some Title",
          url: "https://example.com",
          description: "Some description"
        })
      {:ok, video} = Multimedia.create_video(user, attrs)

      video
  end
end
