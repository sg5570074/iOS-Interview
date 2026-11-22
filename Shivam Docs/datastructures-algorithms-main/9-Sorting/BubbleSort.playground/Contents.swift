import UIKit

/*
 ___      _    _    _       ___          _
| _ )_  _| |__| |__| |___  / __| ___ _ _| |_
| _ \ || | '_ \ '_ \ / -_) \__ \/ _ \ '_|  _|
|___/\_,_|_.__/_.__/_\___| |___/\___/_|  \__|

 */




//class BubbleSort {
//    func sort(_ array: [Int]) -> [Int] {
//        var arr = array
//        let n = arr.count
//        for i in 0..<n-1 {
//            for j in 0..<n-i-1 {
//                if arr[j] > arr[j+1] {
//                    // swap
//                    let temp = arr[j]
//                    arr[j] = arr[j+1]
//                    arr[j+1] = temp
//                }
//            }
//        }
//        
//        return arr
//    }
//}
//
//let bubbleSort = BubbleSort()
//bubbleSort.sort([5, 4, 3, 2, 1])


//MARK: - Bubble

func bubbleSort(_ arr: [Int]) -> [Int] {
    if arr.isEmpty { return [] }
    var temp = arr
    for i in 0..<temp.count-1 {
        for j in 0..<temp.count-1-i {
            if temp[j] > temp[j+1] {
                temp.swapAt(j, j+1)
            }
        }

    }

    return temp
}

var bubbleSortArr = bubbleSort([5, 4, 7, 2, 1, 3])
print("bubble sort \(bubbleSortArr)")


// MARK: - Selection Sort

//First we find the smallest element and swap it with the first element. This way we get the smallest element at its correct position.
//Then we find the smallest among remaining elements (or second smallest) and swap it with the second element.
//We keep doing this until we get all elements moved to correct position.

func selectionSort(_ arr: [Int]) -> [Int] {
    if arr.isEmpty { return [] }
    var temp = arr
    for i in 0..<temp.count-1 {

        var minIndex = i
        for j in i+1..<temp.count {
            if temp[j] <= temp[minIndex] {
                minIndex = j
            }
        }
        temp.swapAt(minIndex, i)
    }
    return temp
}

var selectionSortArr = selectionSort([5, 4, 7, 2, 2, 1, 3])
print("SelectionSort: \(selectionSortArr)")


// MARK: - Insertion Sort

func insertionSort<T: Comparable>(_ arr: [T]) -> [T] {
    if arr.isEmpty { return [] }
    var temp = arr
    for i in 1...temp.count-1 {
        var value = temp[i]
        var hole = i

        while(hole>0 && temp[hole-1]>value) {
            temp[hole] = temp[hole-1]
            hole = hole-1
        }
        temp[hole] = value
    }

    return temp
}

var insertionSortArr = insertionSort([5, 4, 7, 2, 2, 1, 3])
print("Insertion sort : \(insertionSortArr)")


//MARK: - Merge Sort

func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    // Base case: An array with 0 or 1 element is already sorted
    guard array.count > 1 else { return array }

    // Split the array into two halves
    let middleIndex = array.count / 2
    let leftArray = Array(array[..<middleIndex])
    let rightArray = Array(array[middleIndex...])

    // Recursively sort each half
    let sortedLeft = mergeSort(leftArray)
    let sortedRight = mergeSort(rightArray)

    // Merge the two sorted halves
    return merge(sortedLeft, sortedRight)
}

private func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var sortedArray: [T] = []

    // Compare elements from both arrays and append the smaller one
    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] <= right[rightIndex] {
            sortedArray.append(left[leftIndex])
            leftIndex += 1
        } else {
            sortedArray.append(right[rightIndex])
            rightIndex += 1
        }
    }

    // Append any remaining elements from the left array
    while leftIndex < left.count {
        sortedArray.append(left[leftIndex])
        leftIndex += 1
    }

    // Append any remaining elements from the right array
    while rightIndex < right.count {
        sortedArray.append(right[rightIndex])
        rightIndex += 1
    }

    return sortedArray
}
var mergeSortArr = mergeSort([5, 4, 7, 2, 2, 1, 3])
print("MergeSortArr: \(mergeSortArr)")

var arr1 = [1,2,3,4,5,6,7]
arr1[..<3]
arr1[3...]

//MARK: - Quick Sort

func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    // Base case: Arrays with 0 or 1 element are already sorted
    guard array.count > 1 else { return array }

    // Choose a pivot (e.g., the first element)
    let pivot = array[array.count / 2]
    print(pivot)

    // Partition the array into three parts
    let less = array.filter { $0 < pivot }      // Elements less than the pivot
    print(less)
    let equal = array.filter { $0 == pivot }   // Elements equal to the pivot
    let greater = array.filter { $0 > pivot }  // Elements greater than the pivot
    print(greater)

    // Recursively sort the less and greater arrays, then combine
    return quickSort(less) + equal + quickSort(greater)
}

var quickSortArr = quickSort([5, 4, 7, 2, 1, 3])
print("quickSortArr: \(quickSortArr)")




//class Fruit{
//    var name = "Apple"{
//
//        didSet{
//            self.name = "Cherry"
//        }
//    }
//    init(){
//        self.name = "Mango"
//    }
//}
//
//let fruit = Fruit()
//print(fruit.name)
//
//fruit.name = "Sahil"
//print(fruit.name)
