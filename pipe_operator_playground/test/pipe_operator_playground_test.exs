defmodule PipeOperatorPlaygroundTest do
  use ExUnit.Case

  test "ps_ax outputs some processes" do
    output = """
    PID   TT  STAT      TIME COMMAND
      1   ??  Ss     0:07.40 /sbin/launchd
     38   ??  Ss     0:02.29 /usr/sbin/syslogd
     39   ??  Ss     0:01.18 /usr/libexec/UserEventAgent (System)
     41   ??  Ss     0:02.13 /usr/libexec/kextd
     42   ??  Ss     0:05.38 /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/FSEvents.framework/Versions/A/Support/fseventsd
     44   ??  Ss     0:00.06 /usr/libexec/thermald
     46   ??  Ss     0:00.21 /System/Library/CoreServices/appleeventsd --server
     47   ??  Ss     0:01.46 /usr/libexec/configd
    """
    assert Unix.ps_ax == output
  end

  test "grep(lines, thing) returns lines that match 'thing'" do
    lines = """
    foo
    bar
    thing foo
    baz
    thing qux
    """
    output = ["thing foo", "thing qux"]
    assert Unix.grep(lines, ~r/thing/) == output
  end

  test "awk(input, l) splits on whitespace and return the first column" do
    input = ["foo bar", " baz    qux"]
    output = ["foo", "baz"]
    assert Unix.awk(input, 1) == output
  end

  test "the whole pipeline works" do
    assert (Unix.awk(Unix.grep(Unix.ps_ax, ~r/System/), 1)) == ["39", "42", "46"]
    assert (Unix.ps_ax |> Unix.grep(~r/System/) |> Unix.awk(1)) == ["39", "42", "46"]
  end
end
