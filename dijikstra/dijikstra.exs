defmodule Dijikstra do
  @spec shortest_path(%{}, any, any) :: any
  def shortest_path(graph, start, stop, distance \\ 0, vlist \\ []) do
    vlist = case length(vlist) do
              0 -> [start]
              _ -> vlist
            end
    paths = graph[start]
    edge = for tup <- paths, elem(tup, 1) == stop, do: tup
    if length(edge) != 0 do
      [{dis, stop}] = edge
      {vlist ++ [stop], distance + dis}
    else
      slist = Enum.sort_by(paths, fn x -> elem(x, 0) end)
      not_vis = for i<- slist, not Enum.member?(vlist, elem(i, 1)), do: i
      {val, next} = hd not_vis

      shortest_path(Map.delete(graph, start), next, stop, distance + val, vlist ++ [next])
    end
  end
end
