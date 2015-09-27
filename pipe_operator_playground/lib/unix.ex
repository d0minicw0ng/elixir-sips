defmodule Unix do
  def ps_ax do
    """
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
  end

  def grep(input, match) do
    String.split(input, "\n")
      |> Enum.filter(fn(line) -> Regex.match?(match, line) end)
  end

  def awk(lines, column) do
    Enum.map(lines, fn(line) ->
      String.strip(line)
        |> Unix.regex_split(~r/ /)
        |> Enum.at(column-1)
    end)
  end

  def regex_split(line, regex) do
    Regex.split(regex, line, trim: true)
  end
end
