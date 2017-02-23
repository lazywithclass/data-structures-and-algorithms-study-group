ExUnit.start

defmodule DijikstraTest do
  use ExUnit.Case, async: true

  @graph %{
            'a' => [{7,'b'}, {9,'c'}, {14, 'f'}],
            'b' => [{7,'a'}, {10,'c'}, {15, 'd'}],
            'c' => [{10, 'b'}, {11,'d'}, {2,'f'}],
            'd' => [{15, 'b'}, {11, 'c'}, {6, 'e'}],
            'e' => [{9, 'f'}, {6, 'd'}],
            'f' => [{14, 'f'}, {2,'c'}, {9,'e'}]
          }

  test "shortest path {a, e}" do
    assert Dijikstra.shortest_path(@graph, 'a', 'e') == {['a', 'b', 'c', 'f', 'e'], 28}
  end
  test "shortest path {a,c}" do
    assert Dijikstra.shortest_path(@graph, 'a', 'c') == {['a', 'c'], 9}
  end
  test "shortest path {b, c}" do
    assert Dijikstra.shortest_path(@graph, 'b', 'c') == {['b', 'c'], 10}
  end
  test "shortest path {b, d}" do
    assert Dijikstra.shortest_path(@graph, 'b', 'd') == {['b', 'd'], 15}
  end
  test "shortest path {b, f}" do
    assert Dijikstra.shortest_path(@graph, 'b', 'f') == {['b', 'a', 'f'], 21}
  end
end
