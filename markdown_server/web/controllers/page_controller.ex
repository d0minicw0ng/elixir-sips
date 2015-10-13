defmodule MarkdownServer.PageController do
  use MarkdownServer.Web, :controller
  alias MarkdownServer.Renderer

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, _params) do
    document = Renderer.render_string("this is a doc")
    html(conn, html_for(document))
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
end
