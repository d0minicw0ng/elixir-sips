defmodule MarkdownServer.PageView do
  use MarkdownServer.Web, :view
  use Eml.HTML

  def index_html(markdown_files) do
    markup =
      html do
        head do
          title "Index"
        end

        body do
          h1("Index of markdown files")
          ul do
            Enum.map markdown_files, fn(file) ->
              li do
                a [href: "/pages/#{file}"], file
              end
            end
          end
        end
      end

    Eml.compile(markup)
  end

  def html_for(rendered_document) do
    markup =
      html do
        head do
          title rendered_document.title
        end

        body do
          rendered_document.body
        end
      end

    Eml.compile(markup, escape: false)
  end
end
