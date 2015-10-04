defmodule ExactorTestTest do
  use ExUnit.Case

  test "a basic actor" do
    {:ok, list} = ListActor.start
    assert ListActor.get(list) == []

    :ok = ListActor.put(list, :banana)
    assert ListActor.get(list) == [:banana]

    :ok = ListActor.put(list, :apple)
    assert ListActor.get(list) == [:banana, :apple]

    :ok = ListActor.take(list, :banana)
    assert ListActor.get(list) == [:apple]
  end

  test "a singleton" do
    {:ok, count} = CountActor.start
    assert CountActor.get(count) == 1

    CountActor.inc(count)
    assert CountActor.get(count) == :two

    CountActor.inc(count)
    CountActor.inc(count)
    CountActor.inc(count)
    assert CountActor.get(count) == 5

    CountActor.dec(count)
    assert CountActor.get(count) == 4
  end
end
