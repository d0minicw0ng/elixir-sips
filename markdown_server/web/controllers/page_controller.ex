defmodule MarkdownServer.PageController do
  use MarkdownServer.Web, :controller
  alias MarkdownServer.Renderer
  alias MarkdownServer.PageView

  def index(conn, _params) do
    Phoenix.Controller.html(conn, PageView.index_html(markdown_files))
  end

  def show(conn, _params) do
    document = conn |> requested_file |> Renderer.render
    Phoenix.Controller.html(conn, PageView.html_for(document))
  end

  defp base_dir do
    System.get_env("MARKDOWN_SERVER_DIR") || default_base_dir
  end

  defp default_base_dir do
    "./test/support/sample_files/"
  end

  defp requested_file(conn) do
    "#{base_dir}#{conn.params["page"]}"
  end

  defp files, do: File.ls!(base_dir)

  defp markdown_files do
    files |>
      Enum.filter(fn(filename) ->
        String.ends_with?(filename, [".md", ".markdown"])
      end)
  end
end
