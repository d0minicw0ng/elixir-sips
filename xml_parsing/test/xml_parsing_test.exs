defmodule XmlParsingTest do
  use ExUnit.Case

  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText,    from_lib: "xmerl/include/xmerl.hrl")

  def sample_xml do
    """
    <html>
      <head>
        <title>XML Parsing</title>
      </head>
      <body>
        <p>Neato</p>
        <ul>
          <li>First</li>
          <li>Second</li>
        </ul>
      </body>
    </html>
    """
  end

  test "parsing the title out" do
    {xml, _rest}    = :xmerl_scan.string(:erlang.bitstring_to_list(sample_xml))
    [title_element] = :xmerl_xpath.string('/html/head/title/text()', xml)
    title           = xmlText(title_element, :value)

    assert title == 'XML Parsing'
  end

  test "parsing the p tag" do
    {xml, _rest} = :xmerl_scan.string(:erlang.bitstring_to_list(sample_xml))
    [p_element]  = :xmerl_xpath.string('/html/body/p/text()', xml)
    text         = xmlText(p_element, :value)

    assert text == 'Neato'
  end

  test "parsing the li tags and mapping them" do
    {xml, _rest} = :xmerl_scan.string(:erlang.bitstring_to_list(sample_xml))
    li_elements  = :xmerl_xpath.string('/html/body/ul/li/text()', xml)
    texts        = li_elements |> Enum.map(fn(li_element) -> xmlText(li_element, :value) end)

    assert texts == ['First', 'Second']
  end
end
