defmodule RumblWeb.VideoControllerTest do
  use RumblWeb.ConnCase, async: true

  @create_attrs %{
    url: "http://example.com/video.mp4",
    title: "some title",
    description: "some description",
  }

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each([
      get(conn, Routes.video_path(conn, :new)),
      get(conn, Routes.video_path(conn, :index)),
      get(conn, Routes.video_path(conn, :show, "123")),
      get(conn, Routes.video_path(conn, :edit, "123")),
      get(conn, Routes.video_path(conn, :update, "123", %{})),
      get(conn, Routes.video_path(conn, :create, %{})),
      get(conn, Routes.video_path(conn, :delete, "123"))
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  describe "with a logged-in user" do
    alias Rumbl.Multimedia

    setup %{conn: conn, login_as: username} do
      user = user_fixture(username: username)
      conn = assign(conn, :current_user, user)

      {:ok, conn: conn, user: user}
    end

    @tag login_as: "max"
    test "lists all user's videos on index", %{conn: conn, user: user} do
      user_video = video_fixture(user, title: "Funny cats")
      other_video = video_fixture(
        user_fixture(username: "other"),
        title: "Another video")

      conn = get conn, Routes.video_path(conn, :index)
      response = html_response(conn, 200)
      assert response =~ "Listing Videos"
      assert response =~ user_video.title
      refute response =~ other_video.title
    end

    @invalid_attrs %{title: "invalid"}

    defp video_count, do: Enum.count(Multimedia.list_videos())

    @tag login_as: "max"
    test "creates user video and redirects", %{conn: conn, user: user} do
      create_conn = post conn, Routes.video_path(conn, :create), video: @create_attrs

      assert %{id: id} = redirected_params(create_conn)
      assert redirected_to(create_conn) == Routes.video_path(create_conn, :show, id)

      conn = get conn, Routes.video_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Video"

      assert Multimedia.get_video!(id).user_id == user.id
    end

    @tag login_as: "max"
    test "does not create video, renders errors when invalid", %{conn: conn} do
      count_before = video_count()

      conn = post conn, Routes.video_path(conn, :create), video: @invalid_attrs
      assert html_response(conn, 200) =~"check the errors"
      assert video_count() == count_before
    end
  end

  test "authorized actions against access by other users", %{conn: conn} do
    owner = user_fixture(username: "owner")
    video = video_fixture(owner, @create_attrs)
    non_owner = user_fixture(username: "sneaky")
    conn = assign(conn, :current_user, non_owner)

    assert_error_sent :not_found, fn ->
      get(conn, Routes.video_path(conn, :show, video))
    end

    assert_error_sent :not_found, fn ->
      get(conn, Routes.video_path(conn, :edit, video))
    end

    assert_error_sent :not_found, fn ->
      get(conn, Routes.video_path(conn, :update, video, video: @create_attrs))
    end

    assert_error_sent :not_found, fn ->
      get(conn, Routes.video_path(conn, :delete, video))
    end
  end
end
