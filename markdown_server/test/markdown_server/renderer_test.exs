defmodule MarkdownServer.RendererTest do
  use ExUnit.Case

  test "renders markdown documents from files" do
    rendered_document = MarkdownServer.Renderer.render("./test/support/sample_files/basic.md")
    expected_body = "<p>This is a basic doc.</p>\n"
    assert %MarkdownServer.RenderedDocument{body: expected_body} == rendered_document
  end

  test "renders markdown documents from strings" do
    rendered_document = MarkdownServer.Renderer.render_string("This doc has no title.")
    expected_body     = "<p>This doc has no title.</p>\n"
    expected_title    = "Untitled Document"
    assert %MarkdownServer.RenderedDocument{title: expected_title, body: expected_body} == rendered_document
  end

  test "extracts titles from markdown documents" do
    rendered_document = MarkdownServer.Renderer.render_string("# This is a title\n\nThis doc has no title.")
    expected_body     = "<h1>This is a title</h1>\n\n<p>This doc has no title.</p>\n"
    expected_title    = "This is a title"
    assert %MarkdownServer.RenderedDocument{title: expected_title, body: expected_body} == rendered_document
  end
end

