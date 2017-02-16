defmodule QuickSort do
  @moduledoc"""
  Implementation of quicksort in Elixir
  """
  @examples"""
    unsorted = [13,4,1,9,2,3,10]
    QuickSort.sort(unsorted)
  """

  @spec sort([]) :: []
  def sort([]), do: []

  def sort([head|tail]) do
    {smaller, larger} = Enum.partition(tail, &(&1 < head))
    sort(smaller) ++ [head] ++ sort(larger)
  end
end

