defmodule QuickSortTest do
  use ExUnit.Case
  doctest QuickSort

  @unsorted [13,4,1,9,2,3,10]
  test "test the array is sorted properly" do
    assert QuickSort.sort(@unsorted) == [1,2,3,4,9,10,13]
  end
end
