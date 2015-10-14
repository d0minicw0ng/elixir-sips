defmodule MarkdownServer.PageController do
  use MarkdownServer.Web, :controller
  alias MarkdownServer.Renderer

  def index(conn, _params) do
    html(conn, index_html)
  end

  def show(conn, _params) do
    document = conn |> requested_file |> Renderer.render
    html(conn, html_for(document))
  end

  defp base_dir do
    "./test/support/sample_files/"
  end

  defp requested_file(conn) do
    "#{base_dir}#{conn.params["page"]}"
  end

  defp markdown_files, do: File.ls!(base_dir)

  defp a(element), do: "<a href='/pages/#{element}'>#{element}</a>"

  defp li(element), do: "<li>#{element}</li>"

  defp ul(list) do
    elements = list
                |> Enum.map(&a/1)
                |> Enum.map(&li/1)
    "<ul>#{elements}</ul>"
  end

  defp html_for(rendered_document) do
    """
    <html>
      <head>
        <title>#{rendered_document.title}</title>
      </head>
      <body>
        #{rendered_document.body}
      </body>
    </html>
    """
  end

  defp index_html do
    """
    <html>
      <head>
        <title>Index</title>
      </head>
      <body>
        <h1>Index of markdown files</h1>
        #{ul(markdown_files)}
      </body>
    </html>
    """
  end
end
