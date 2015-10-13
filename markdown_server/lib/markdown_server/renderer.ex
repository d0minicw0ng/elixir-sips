defmodule MarkdownServer.RenderedDocument do
  defstruct body: nil, title: "Untitled Document"
end

defmodule MarkdownServer.Renderer do
  def render_string(string) do
    body = string |> Markdown.to_html
    %MarkdownServer.RenderedDocument{body: body, title: title_for(body)}
  end

  defp title_for(body) do
    case Regex.named_captures(title_matcher, body) do
      %{"title" => title} -> title
      nil -> "Untitled Document"
    end
  end

  defp title_matcher do
    ~r/<h1>(?<title>.*)<\/h1>/
  end
end
