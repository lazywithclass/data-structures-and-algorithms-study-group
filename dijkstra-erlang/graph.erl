% run
% ------
% Calculates shortest path for the given graph 'example.gif' with Dijkstra alg.
% c(graph).
% graph:run_dijkstra().

-module(graph).
-export([run_dijkstra/0]).

run_dijkstra() ->
  {G, V} = create(),
  dijkstra(G, V, "A", "F").

create() ->
  Graph = digraph:new(),
  A = digraph:add_vertex(Graph, "A"),
  B = digraph:add_vertex(Graph, "B"),
  C = digraph:add_vertex(Graph, "C"),
  D = digraph:add_vertex(Graph, "D"),
  E = digraph:add_vertex(Graph, "E"),
  F = digraph:add_vertex(Graph, "F"),
  G = digraph:add_vertex(Graph, "G"),
  digraph:add_edge(Graph, A, D, 2),
  digraph:add_edge(Graph, A, C, 1),
  digraph:add_edge(Graph, C, D, 1),
  digraph:add_edge(Graph, C, B, 2),
  digraph:add_edge(Graph, C, E, 3),
  digraph:add_edge(Graph, D, G, 1),
  digraph:add_edge(Graph, B, F, 3),
  digraph:add_edge(Graph, E, F, 2),
  digraph:add_edge(Graph, G, F, 1),
  {Graph, [A, B, C, D, E, F, G]}.

% Return minimum int, in a list of atoms {string, int}
minimum([]) ->
  io:format("can not find minimum of empty list");
minimum([First | Tail]) ->
  minimum(First, Tail).

minimum(Min, []) ->
  Min;
minimum({_, MinValue}, [{Elem, ElemValue} | Tail]) when ElemValue < MinValue ->
  minimum({Elem, ElemValue}, Tail);
minimum(Min, [_ | Tail]) ->
  minimum(Min, Tail).

% Edge vertex destination in list of vertices?
contains([], _) ->
  false;
contains([Vx | _], {_, _, Vx2, _}) when Vx == Vx2 ->
  true;
contains([_ | L], Edge) ->
  contains(L, Edge).

% remove Vertex from list of Vertices
remove(Vertex, L) ->
  lists:filter(fun (V) -> not(V==Vertex) end, L).

% update the distances when values are lower
updateDistances(V, [], _) ->
  V;
updateDistances({Name, Dist, Previous}, [{N, D} | _], _) when Name == N, D >= Dist ->
  {Name, Dist, Previous};
updateDistances({Name, _, _}, [{N, D} | _], Actual) when Name == N ->
  {Name, D, Actual};
updateDistances(V, [_ | L], Actual) ->
  updateDistances(V, L, Actual).

% Once the Heap is complete, return the path of the final solution
path(_, Path, Target) when Target == "Start" ->
  Path;
path(Heap, Path, Target) ->
  {_, Distance, PrevNode} = lists:nth(1, lists:filter(fun({N, _, _}) -> N == Target end, Heap)),
  path(Heap, [{Target, Distance}] ++ Path, PrevNode).

% Starting vertex: the first element in Vertices.
% Target / ending vertex: last vertex in Vertices.
dijkstra(Graph, Vertices, Org, Dest) ->
  Remain = remove(Org, Vertices),
  Heap = [{Org, 0, "Start"}],
  dijkstra(Graph, [Org], Remain, Heap ++ [{X, 999, ""} || X <- Remain], {Org, 0}, Dest).

dijkstra(_, _, [], Heap, _, TargetVx) -> 
  path(Heap, [], TargetVx);
dijkstra(Graph, Visited, Remain, Heap, {ActualVxName, ActualVxDist}, TargetVx) ->
  % Get list of edges adjacents to the actual vertex included in remain list.
  Edges = lists:filter(fun(X) -> contains(Remain, X) end, [digraph:edge(Graph, E) || E <- digraph:edges(Graph, ActualVxName)]),
  % Extract destination vertices from the list of edges.
  Vertices = [{Vx2, Dist + ActualVxDist} || {_, _, Vx2, Dist} <- Edges],
  % Update all the Heap distances from the list of vertices.
  HeapUpdated = lists:map(fun(X) -> updateDistances(X, Vertices, ActualVxName) end, Heap),
  % Get the remain not visited vertices from the Heap.
  RemainFromHeap = lists:filter(fun({X, _, _}) -> contains(Remain, {"", "", X, ""}) end, HeapUpdated),
  % Select the next vertex to visit, the one with minimum distance.
  NextVx = minimum([{Name, Distance} || {Name, Distance, _} <- RemainFromHeap]),
  dijkstra(Graph, lists:append(element(1, NextVx), Visited), remove(element(1, NextVx), Remain), HeapUpdated, NextVx, TargetVx).
