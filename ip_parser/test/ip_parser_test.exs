defmodule IPPacket do
  defstruct protocol_version: nil, header_length_in_bytes: nil, type_of_service: nil, total_length_in_bytes: nil

  def from_bits(bits) do
    << protocol_version        :: size(4),
       header_length_in_words  :: size(4),
       _type_of_service_legacy :: size(4),
       type_of_service_int     :: size(4),
       total_length_in_bytes   :: size(16),
       _rest                   :: bitstring >> = bits

    %IPPacket{
      protocol_version:       protocol_version,
      header_length_in_bytes: header_length_in_words * (32 /8),
      type_of_service:        type_of_service_for(type_of_service_int),
      total_length_in_bytes:  total_length_in_bytes
    }
  end

  defp type_of_service_for(type_of_service_int) do
    case type_of_service_int do
      8 -> :minimize_delay
      4 -> :maximize_throughput
      2 -> :maximize_reliability
      1 -> :minimize_monetary_cost
      0 -> :unspecified
    end
  end
end

defmodule IpParserTest do
  use ExUnit.Case

  setup do
    bits = File.read!("./sample_packet.bits")
    packet = IPPacket.from_bits(bits)
    {:ok, packet: packet}
  end

  test "getting protocol version", meta do
    assert meta[:packet].protocol_version == 4
  end

  test "getting header length in bytes", meta do
    assert meta[:packet].header_length_in_bytes == 20
  end

  test "getting type of service", meta do
    assert meta[:packet].type_of_service == :unspecified
  end

  test "getting total length in bytes", meta do
    assert meta[:packet].total_length_in_bytes == 44
  end
end
