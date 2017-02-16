quicksort = (array) => {
  if (array.length <= 1) return array

  let pivotIndex = getPivotIndex(array.length),
      pivot = array[pivotIndex],
      lessThan = [],
      greaterThan = []

  array.forEach((n, index) => {
    if (index === pivotIndex) return
    if (n <= pivot) lessThan.push(n)
    else greaterThan.push(n)
  })

  return quicksort(lessThan)
    .concat([pivot])
    .concat(quicksort(greaterThan));
}

getPivotIndex = n => Math.floor(Math.random() * n)

console.log(quicksort([15, 13, 8, 9, 21, 1, 5]))
console.log(quicksort([1, 27, -5, 44, 0, 1, 22]))
console.log(quicksort([10, 3, 88, 19, 20, 21, 25]))
console.log(quicksort([]))
console.log(quicksort([0, 0, 0, 0]))
