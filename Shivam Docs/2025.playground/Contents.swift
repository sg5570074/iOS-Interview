import Foundation
import CoreFoundation
//import UIKit

//var greeting = "Hello, playground"

// Q1>
//func solution(_ S : String) -> String {
//    var str = S
//    var noSpace = str.replacingOccurrences(of: " ", with: "")
//    var noSpacenoDash = noSpace.replacingOccurrences(of: "-", with: "")
//
//    var count = -2
//    var result:[Character] = []
//    for i in noSpacenoDash {
//        result.append(i)
//
//        if (count%3 == 0) {
//            result.append("-")
//        }
//        count = count + 1
//    }
//
//    if result.last == "-" {
//        result = result.dropLast()
//    }
//
//    var secondLastIndex = result.count - 2
//
//    if result[secondLastIndex] == "-" {
//        result[secondLastIndex] = result[secondLastIndex-1]
//        result[secondLastIndex-1] = "-"
//    }
//
//    return String(result)
//}
//
//
//var str = "00-44   48 5555 83"
//solution(str)
////"004-448-555-583-6"
//print("aefrsg")


// Q2>

//class Node {
//    var key:Int
//    var left:Node?
//    var right:Node?
//
//    init(_ data: Int, left: Node? = nil, right: Node? = nil) {
//        self.key = data
//        self.left = left
//        self.right = right
//    }
//}
//
//class BST {
//  private var root:Node?
//
//    func insertNode(_ data: Int) {
//        root = insert(root, data: data)
//    }
//
//    private func insert(_ node: Node?, data: Int) -> Node? {
//        guard let node else {
//            return Node(data)
//        }
//
//        if data < node.key {
//            node.left = insert(node.left, data: data)
//        }
//
//        else if data > node.key{
//            node.right = insert(node.right, data: data)
//        }
//
//        return node
//    }
//
//    func findMin() {
//        guard let root else {
//            return
//        }
//       print(minData(root))
//    }
//
//    private func minData(_ node: Node) -> Int {
//        if node.left ==  nil {
//            return node.key
//        }
//
//       return minData(node.left!)
//    }
//
//    func prettyPrint() {
//        // Hard code print for tree depth = 3
//        let rootLeftKey = root?.left == nil ? 0 : root?.left?.key
//        let rootRightKey = root?.right == nil ? 0 : root?.right?.key
//
//        var rootLeftLeftKey = 0
//        var rootLeftRightKey = 0
//
//        if root?.left != nil {
//            rootLeftLeftKey = root?.left?.left == nil ? 0 : root?.left?.left?.key as! Int
//            rootLeftRightKey = root?.left?.right == nil ? 0 : root?.left?.right?.key as! Int
//        }
//
//        var rootRightLeftKey = 0
//        var rootRightRightKey = 0
//
//        if root?.right != nil {
//            rootRightLeftKey = root?.right?.left == nil ? 0 : root?.right?.left?.key as! Int
//            rootRightRightKey = root?.right?.right == nil ? 0 : root?.right?.right?.key as! Int
//        }
//
//        let str = """
//                      \(root!.key)
//                    /  \\
//                   \(rootLeftKey!)    \(rootRightKey!)
//                  / \\  / \\
//                 \(rootLeftLeftKey)  \(rootLeftRightKey) \(rootRightLeftKey)   \(rootRightRightKey)
//        """
//
//        print(str)
//    }
//
//}
//
//var bst = BST()
//bst.insertNode(5)
//bst.insertNode(3)
//bst.insertNode(8)
//bst.insertNode(1)
//bst.insertNode(4)
//bst.insertNode(7)
//bst.insertNode(9)
//
//bst.prettyPrint()
//
//bst.findMin()


//Q3> 3rd largest Element

//func thirdLargest(_ arr: [Int]) -> Int {
//    var first = Int.min
//    var second = -1
//
//    for i in 0...arr.count-1 {
//
//        if arr[i] > first  {
//            first = arr[i]
//        }else arr[i] > first && arr
//    }
//
//return first
//}
//
//let arr = [2,1,5,3,11,55,22]
//print(thirdLargest(arr))



//let semaphore = DispatchSemaphore(value:0)
//
//func printNumber() {
//    for i in 1...26 {
//        print("\(i)", terminator: " ")
//        semaphore.signal()
//    }
//}
//
//func printAlphbets() {
//    for i in 0..<26 {
//        semaphore.wait()
//        let letter = Character(UnicodeScalar(65+i)!)
//        print(letter, terminator: " ")
//
//    }
//}
//
//DispatchQueue.global().async {
//    printNumber()
//}
//
//DispatchQueue.global().async {
//    printAlphbets()
//}
//
//sleep(1)
//RunLoop.current.run(until: Date().addingTimeInterval(1))


// MARK: - Recursion

// MARK: 1Reverse an array
//func reverse(_ i:Int, _ arr:inout [Int]) {
//    let len = arr.count
//    if i>=len/2 { return }
//
//    arr.swapAt(i, len-i-1)
//
//    reverse(i+1, &arr)
//
//}
//
//var arr = [3,4,2,1,5]
//
//reverse(0, &arr)
//print("Reverse Array: \(arr)")


//MARK: 2: Palindrome of String
//func isValidPalindromString(_ i: Int, _ str: inout [Character]) -> Bool {
//    let len = str.count
//
//    if i>len/2 { return true }
//
//    if (str[i] != str[len-1-i]) {
//        return false
//    }
//
//    return isValidPalindromString(i+1, &str)
//}
//var arrStr = Array("MADAM")
//
//isValidPalindromString(0, &arrStr)


//MARK: 2: Fibonacci
//func fibo(_ n: Int) -> Int {
//    if n<=1 { return n }
//
//    return fibo(n-1) + fibo(n-2)
//}
//
//print(fibo(3))


//MARK: 3 .Subsequences
//func printSubcequences(_ i:Int, _ subsets:[Int], _ arr: [Int]) {
//
//    if i>=(arr.count) {
//        print(subsets)
//        return
//    }
//
//    // Take current element
//    printSubcequences(i+1, subsets+[arr[i]], arr)
//    // Not Take current element
//    printSubcequences(i+1, subsets, arr)
//}
//
//var seqArr = [3,1,2]
//printSubcequences(0, [], seqArr)


//MARK: 4.Subsequences sum equal to target
//func printsubcequencesSum (_ arr : [Int], _ target: Int) {
//
//    func subcequencesSum(_ i:Int, _ subsets:[Int], _ sum: Int) {
//
//        if i>=(arr.count) {
//            if sum == target {
//                print(subsets)
//            }
//            return
//        }
//
//        // Take current element
//        subcequencesSum(i+1, subsets+[arr[i]], sum + arr[i])
//        // Not Take current element
//        subcequencesSum(i+1, subsets, sum)
//    }
//
//    subcequencesSum(0, [], 0)
//}
//
//printsubcequencesSum([3,1,2,4,1], 4)


//MARK: 5. Print Any one SubSequence whose sum is sum.

//func printOnesubcequencesSum (_ arr : [Int], _ target: Int) {
//
//    func oneSubcequencesSum(_ i:Int, _ subsets:[Int], _ sum: Int) -> Bool {
//
//        if i>=(arr.count) {
//            if sum == target {
//                print(subsets)
//                return true
//            } else {
//                return false
//            }
//
//        }
//
//        // Take current element
//        if oneSubcequencesSum(i+1, subsets+[arr[i]], sum + arr[i]) ==  true { return  true}
//        // Not Take current element
//        if oneSubcequencesSum(i+1, subsets, sum) ==  true { return  true}
//
//        return false
//    }
//
//    var seqArr = [3,1,2,4]
//    oneSubcequencesSum(0, [], 0)
//}
//printOnesubcequencesSum([3,1,2,4,1], 4)


//MARK: 6. Count the Subsequences whose sum equal to target
//func printsubcequencesSum (_ arr : [Int], _ target: Int) {
//
//    func subcequencesSum(_ i:Int, _ subsets:[Int], _ sum: Int) -> Int {
//
//        if i>=(arr.count) {
//            if sum == target {
//                print(subsets)
//                return 1
//            }
//
//            return 0
//        }
//
//        // Take current element
//       var leftCount = subcequencesSum(i+1, subsets+[arr[i]], sum + arr[i])
//        print("Left: \(leftCount)")
//        // Not Take current element
//       var rightCount = subcequencesSum(i+1, subsets, sum)
//        print("Right: \(rightCount)")
//
//        return leftCount + rightCount
//    }
//
//    print(" Total SubSeq: \(subcequencesSum(0, [], 0))")
//}
//
//(printsubcequencesSum([3,1,2,4,1], 4))


//MARK: 7. Print Combinations whose sum equal to target and here any element is repeated any number of time
//func printsubcequencesSum (_ arr : [Int], _ target: Int) {
//
//    func subcequencesSum(_ i:Int, _ subsets:[Int], _ sum: Int) {
//
//        if sum == target {
//            print(subsets)
//            return
//
//        }
//
//        if i>=(arr.count) || sum > target {
//
//            return
//        }
//
//        // Take current element, without moving to next index, everytime ,we keeps on adding same number. unless it breaks the base condition
//
//        subcequencesSum(i, subsets+[arr[i]], sum + arr[i])
//
//
//        // Not Take current element
//       subcequencesSum(i+1, subsets, sum)
//
//    }
//
//    print(" Total SubSeq: \(subcequencesSum(0, [], 0))")
//}
//
//(printsubcequencesSum([2, 3, 6, 7], 7))


// MARK: 8 Print Subsequences whose sum equal to target and here any element is only use one time, and all subsets should be in sorted order

//func printsubcequencesSum (_ arr : [Int], _ target: Int) {
//
//    func subcequencesSum(_ i:Int, _ subsets:[Int], _ sum: Int) {
//
//        if sum == target {
//            print(subsets)
//            return
//
//        }
//
//        for j in i..<arr.count {
//            if j>i && arr[j] == arr[j-1] {
//                continue
//            }
//            if sum > target  {
//                break
//            }
//            subcequencesSum(j+1, subsets+[arr[j]], sum + arr[j])
//        }
//
//        return
//    }
//
//    print(" Total SubSeq: \(subcequencesSum(0, [], 0))")
//}
//
//(printsubcequencesSum([1, 1, 1, 2, 2], 4))


//MARK: 9. Subsequences sum and it should be sorted
//func printsubcequencesSum (_ arr : [Int]) {
//
//    var resultOfSum = [Int]()
//    func subcequencesSum(_ i:Int, _ subsets:[Int], _ sum: Int) {
//
//        if i>=(arr.count) {
//            resultOfSum.append(sum)
//            return
//        }
//
//        // Take current element
//        subcequencesSum(i+1, subsets+[arr[i]], sum + arr[i])
//        // Not Take current element
//        subcequencesSum(i+1, subsets, sum)
//    }
//
//    subcequencesSum(0, [], 0)
//    print(resultOfSum.sorted())
//}
//
//printsubcequencesSum([3,1,2])


//MARK: 10 Print all Permutations of a String/Array
//func permute<T>(_ array: [T], _ start: Int = 0) {
//    if start == array.count - 1 {
//        print(array)
//        return
//    }
//
//    var array = array
//    for i in start..<array.count {
//        array.swapAt(start, i)
//        permute(array, start + 1)
//        array.swapAt(start, i) // Backtrack
//    }
// }
//
// Example usage:
// permute([1, 2, 3])



//MARK: 11 N Queen Problem, to print all possible ways, so that no queen can be conflicted

//Backtracking Approach:
//
//We place a queen in the first valid row of the current column.
//We recursively move to the next column.
//If placing a queen in a column leads to a dead-end, we backtrack.


//isSafe(row:col:) Function:
//
//Ensures no queen exists in the same row.
//Checks upper-left diagonal.
//Checks lower-left diagonal.


//Prints Board Configuration:
//
//Q represents a queen.
//. represents an empty space.

//class NQueens {
//    private var size: Int
//    private var board: [[Int]]
//    private var solutions: Int = 0  // Count total solutions
//
//    init(size: Int) {
//        self.size = size
//        self.board = Array(repeating: Array(repeating: 0, count: size), count: size)
//    }
//    
//    func solve() {
//        placeQueens(col: 0)
//        print("Total solutions: \(solutions)")
//    }
//
//    private func placeQueens(col: Int) {
//        if col >= size {
//            printSolution()
//            solutions += 1
//            return
//        }
//
//       // core lines
////        If no row is safe, that means no if condition is satisfied.
////        → So the loop ends without calling placeQueens(col + 1).
////
////        The function placeQueens(2) simply returns to its caller — that’s placeQueens(1).
//        for row in 0..<size {
//            if isSafe(row: row, col: col) {
//                board[row][col] = 1  // Place queen
//                placeQueens(col: col + 1) // Move to next column
//                board[row][col] = 0  // Backtrack
//            }
//        }
//    }
//
//    private func isSafe(row: Int, col: Int) -> Bool {
//        // Check previous columns in the same row
//        for i in 0..<col {
//            if board[row][i] == 1 {
//                return false
//            }
//        }
//
//        // Check upper diagonal (↖)
//        var i = row, j = col
//        while i >= 0 && j >= 0 {
//            if board[i][j] == 1 {
//                return false
//            }
//            i -= 1
//            j -= 1
//        }
//
//        // Check lower diagonal (↙)
//        i = row
//        j = col
//        while i < size && j >= 0 {
//            if board[i][j] == 1 {
//                return false
//            }
//            i += 1
//            j -= 1
//        }
//
//        return true
//    }
//
//    private func printSolution() {
//        for row in board {
//            print(row.map { $0 == 1 ? "Q" : "." }.joined(separator: " "))
//        }
//        print("\n")
//    }
//}
//
//// Example usage:
//let nQueens = NQueens(size: 6) // Change size for different N
//nQueens.solve()

//The time complexity of the N-Queens problem using backtracking is O(N!) (factorial time complexity)

//MARK: 12 Rat Maze problem start from 0,0 to n-1,n-1 . Find no. of possible ways . Moves in all fours Directions i.e D L R U. Print in lexicograpical order

//class RatMaze {
//    private var maze: [[Int]]
//    private var n: Int
//    private var paths: [String] = []
//
//    init(maze: [[Int]]) {
//        self.maze = maze
//        self.n = maze.count
//    }
//
//    func findPaths() -> [String] {
//        if maze[0][0] == 0 || maze[n-1][n-1] == 0 {
//            return [] // No solution if start or end is blocked
//        }
//
//        var visited = Array(repeating: Array(repeating: false, count: n), count: n)
//        backtrack(x: 0, y: 0, path: "", visited: &visited)
//        return paths.sorted() // Sort lexicographically
//    }
//
//    private func backtrack(x: Int, y: Int, path: String, visited: inout [[Bool]]) {
//        // Base Case: Reached Destination
//        if x == n-1 && y == n-1 {
//            paths.append(path)
//            return
//        }
//
//        // Mark current cell as visited
//        visited[x][y] = true
//
//        // Possible moves in lexicographical order: D, L, R, U
//        let moves: [(dx: Int, dy: Int, dir: String)] = [(1, 0, "D"), (0, -1, "L"), (0, 1, "R"), (-1, 0, "U")]
//
//        for move in moves {
//            let newX = x + move.dx
//            let newY = y + move.dy
//
//            if isValid(newX, newY, visited) {
//                backtrack(x: newX, y: newY, path: path + move.dir, visited: &visited)
//            }
//        }
//
//        // Backtrack: Mark current cell as unvisited
//        visited[x][y] = false
//    }
//
//    private func isValid(_ x: Int, _ y: Int, _ visited: [[Bool]]) -> Bool {
//        return x >= 0 && y >= 0 && x < n && y < n && maze[x][y] == 1 && !visited[x][y]
//    }
//}
//
//// Example Usage
//let maze = [
//    [1, 0, 0, 0],
//    [1, 1, 0, 1],
//    [0, 1, 0, 0],
//    [1, 1, 1, 1]
//]
//
//let solver = RatMaze(maze: maze)
//let solutions = solver.findPaths()
//
//if solutions.isEmpty {
//    print("No path found")
//} else {
//    for path in solutions {
//        print(path)
//    }
//}


// MARK: - 1926. Nearest Exit from Entrance in Maze

//func nearestExit(_ maze: [[Character]], _ entrance: [Int]) -> Int {
//    let m = maze.count, n = maze[0].count
//    let (startX, startY) = (entrance[0], entrance[1])
//    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
//    var minStep = [Int]()
//
//    func backtrack(_ x: Int, _ y: Int, _ step: Int) {
//
//        if (x==0 || x==m-1 || y==0 || y==n-1) && !(x == startX && y == startY) {
//            minStep.append(step)
//            return
//        }
//
//        if x<0 || x>m-1 || y<0 || y>n-1 {
//            return
//        }
//
//        if maze[x][y] == "+" {
//            return
//        }
//
//        if visited[x][y] == true {
//            return
//        }
//
//        var moves = [(-1,0),(1,0),(0,-1),(0,1)]
//
//        visited[x][y] = true
//
//        for i in moves {
//            var newx = x+i.0
//            var newy = y+i.1
//
//            backtrack(newx, newy, step+1)
//
//        }
//
//        visited[x][y] = false
//
//
//    }
//
//    backtrack(startX, startY, 0)
//    print(minStep)
//    return minStep.min() ?? -1
//}
//
//var maze: [[Character]] = [
//    ["+","+",".","+"],
//    [".",".",".","+"],
//    ["+","+","+","."]
//]
//nearestExit(maze, [1,0])


// MARK: - 733. Flood Fill

//func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
//    var m = image.count, n = image[0].count
//    var result = Array(repeating: Array(repeating: 0, count: n), count: m)
//    result = image
//
//    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
//
//    var source = image[sr][sc]
//
//
//    func flood(_ x: Int, _ y: Int) {
//
//        //out of Bound
//        if x<0 || x>m-1 || y<0 || y>n-1 {
//            print("index \(x),\(y) out of Bound")
//            return
//        }
//
//        if result[x][y] == color {
//            print("index \(x),\(y) initial is same as target")
//            return
//        }
//
//        //mismatch with source
//        if result[x][y] != source {
//            print("index \(x),\(y) mismatch with source")
//            return
//        }
//
//        //already Visited
//        if visited[x][y] == true {
//            print("index \(x),\(y) already Visited")
//            return
//        }
//
//        visited[x][y] = true
//
//        var moves = [(-1,0),(1,0),(0,-1),(0,1)]
//
//        result[x][y] = color
//
//        for i in moves {
//            var newX = x+i.0
//            var newY = y+i.1
//
//            flood(newX, newY)
//        }
//
//        visited[x][y] = false
//    }
//
//    flood(sr, sc)
//
//    print(result)
//    return result
//}
//
//
//var image = [
//    [1,1,1],
//    [1,1,0],
//    [1,0,1]
//]
//
//var sr = 1
//var sc = 1
//var color = 2
//
//floodFill(image, sr, sc, color)


// MARK: - 70. Climbing Stairs

//func climbStairs(_ n: Int) -> Int {
//    var noOFSteps = 0
//
//    func climb(_ current: Int) {
//        if current > n {
//            return
//        }
//        if current == n {
//            noOFSteps += 1
//            return
//        }
//        climb(current+1)
//        climb(current+2)
//    }
//
//    climb(0)
//    print(noOFSteps)
//    return noOFSteps
//}
//
//climbStairs(3)


// MARK: - 973. K Closest Points to Origin
//func kClosest(_ points: [[Int]], _ k: Int) -> [[Int]] {
//    var sumArr = [Int:Int]()
//    var result = [[Int]]()
//
//    for i in 0..<points.count {
//        let sum = (points[i][0]*points[i][0]) + (points[i][1]*points[i][1])
//        sumArr[i] = sum
//    }
//    let sortArr = sumArr.sorted{ $0.value < $1.value }
//    print(sortArr)
//
//    var j = 0
//    for i in sortArr where j != k {
//        result.append(points[i.key])
//        j += 1
//    }
//
//    return result
//}
//
//
//kClosest([[3,3],[5,-1],[-2,4]], 2)



//MARK: 13. Partioning  if its Palindrome
//func partitioningPalindrome(_ str: String) {
//
//    var strArr = Array(str)
//    var result = [[String]]()
//    var path = [String]()
//
//    func backTracking(_ start: Int) {
//        if start >= strArr.count {
//            result.append(path)
//            //print(strArr)
//            return
//        }
//
//        for end in start..<strArr.count {
//
//            if iSPalindrome(strArr, start, end) {
//                path.append(String(strArr[start...end]))
//                backTracking(end + 1)
//                path.removeLast()
//            }
//
//        }
//
//    }
//
//    func iSPalindrome(_ str: [Character], _ left: Int, _ right: Int) -> Bool {
//        var leftIndex = left
//        var rightIndex = right
//
//        while (leftIndex < rightIndex) {
//            if str[left] != str[right] {
//                return false
//            }
//
//            leftIndex += 1
//            rightIndex -= 1
//        }
//        return true
//    }
//
//    backTracking(0)
//    result.forEach { str in
//        print(str)
//    }
//}
//
//partitioningPalindrome("aabb")
//


// MARK: - Dynamic Programming

//MARK: 14. Find no. of way to climbn from 0th step to Nth Step. you can take euther 1 step or 2 step in swift
//Top-Down Approach (Memoization)
//func fibonacci(_ n: Int, _ memo: inout [Int: Int]) -> Int {
//    if n <= 1 {
//        return n
//    }
//
//    if let cachedValue = memo[n] {
//        return cachedValue
//    }
//
//    memo[n] = fibonacci(n - 1, &memo) + fibonacci(n - 2, &memo)
//    return memo[n]!
//}
//
//func fibonacciMemoization(_ n: Int) -> Int {
//    var memo = [Int: Int]()
//    return fibonacci(n, &memo)
//}
//print(fibonacciMemoization(10)) // Output: 55


//Bottom-Up Approach (Tabulation)
//func fibonacciTabulation(_ n: Int) -> Int {
//    if n <= 1 {
//        return n
//    }
//
//    var dp = [Int](repeating: 0, count: n + 1)
//    dp[1] = 1
//
//    for i in 2...n {
//        dp[i] = dp[i - 1] + dp[i - 2]
//    }
//
//    return dp[n]
//}
//
//print(fibonacciTabulation(10)) // Output: 55

//Optimized Space Approach
//Since we only need the last two Fibonacci numbers at any time, we can reduce space complexity to O(1):
//func fibonacciOptimized(_ n: Int) -> Int {
//    if n <= 1 {
//        return n
//    }
//
//    var prev2 = 0
//    var prev1 = 1
//
//    for _ in 2...n {
//        let current = prev1 + prev2
//        prev2 = prev1
//        prev1 = current
//    }
//
//    return prev1
//}
//
//print(fibonacciOptimized(10)) // Output: 55



//MARK: 15. Find no. of way to climbn from 0th step to Nth Step. you can take euther 1 step or 2 step in swift

                             //OR

//MARK: 15 You are eating a candy bar that is made of pieces in a single row (e.g., a Toblerone). You can bite off 1, 2, or 3 pieces at a time. How many different ways can you eat a bar that is n pieces long?

// Answer : F(n-1) + F(n-2) + F(n-3)



//Recursive Approach (Brute Force)
//func climbStairsRecursive(_ n: Int) -> Int {
//    if n == 0 { return 1 } // 1 way: Stay at step 0
//    if n < 0 { return 0 }  // No way to reach negative steps
//
//    return climbStairsRecursive(n - 1) + climbStairsRecursive(n - 2)
//}
//
//print(climbStairsRecursive(5)) // Output: 8


//Improvement using Memoization (Optimized Recursive)
//func countWays(_ n: Int, _ memo: inout [Int: Int]) -> Int {
//    if n == 0 { return 1 } // 1 way: Stay at the ground (don't move)
//    if n < 0 { return 0 }  // No way to reach negative steps
//
//    if let cachedValue = memo[n] {
//        return cachedValue
//    }
//
//    memo[n] = countWays(n - 1, &memo) + countWays(n - 2, &memo)
//    return memo[n]!
//}
//
//func climbStairsMemoization(_ n: Int) -> Int {
//    var memo = [Int: Int]()
//    return countWays(n, &memo)
//}
//
//print(climbStairsMemoization(5)) // Output: 8

// Bottom-Up DP (Tabulation)
//We use an array dp where dp[i] represents the number of ways to reach step i.
//func climbStairsTabulation(_ n: Int) -> Int {
//    if n == 0 { return 1 }
//    if n == 1 { return 1 }
//
//    var dp = [Int](repeating: 0, count: n + 1)
//    dp[0] = 1
//    dp[1] = 1
//
//    for i in 2...n {
//        dp[i] = dp[i - 1] + dp[i - 2]
//    }
//
//    return dp[n]
//}
//
//print(climbStairsTabulation(5)) // Output: 8


// Optimized Space Approach (Fibonacci)
//func climbStairsOptimized(_ n: Int) -> Int {
//    if n == 0 { return 1 }
//    if n == 1 { return 1 }
//
//    var prev2 = 1
//    var prev1 = 1
//
//    for _ in 2...n {
//        let current = prev1 + prev2
//        prev2 = prev1
//        prev1 = current
//    }
//
//    return prev1
//}
//
//print(climbStairsOptimized(5)) // Output: 8

// MARK: - Maximum Profit Knapsack- 0/1

// Recursive Soln:

//func knapsack(_ wt: [Int], _ val: [Int], _ W: Int, _ n: Int) -> Int {
//    if n == 0 || W == 0 {
//        return 0
//    }
//
//    if wt[n-1] <= W {
//        return max(val[n-1] + knapsack(wt, val, W-wt[n-1], n-1), knapsack(wt, val, W, n-1))
//    } else {
//        return knapsack(wt, val, W, n-1)
//    }
//}
//
//knapsack([1,3,4,5], [1,4,5,7], 7, 4)


//func maxProfitKnapsack(_ weights: [Int], _ profits: [Int], _ capacity: Int) -> Int {
//    
//    var dp: [[Int]] = Array(repeating: Array(repeating: -1, count: capacity + 1), count: weights.count + 1)
//
//
//    for i in 0..<weights.count+1 {
//        for j in 0..<capacity+1 {
//            if i == 0 || j == 0 {
//                dp[i][j] = 0
//            }
//        }
//    }
//
//    for i in 1..<weights.count+1 {
//        for j in 1..<capacity+1 {
//            if weights[i-1] <= j {
//                dp[i][j] = max( profits[i-1] + dp[i-1][j-weights[i-1]], dp[i-1][j] )
//            }else {
//                dp[i][j] = dp[i-1][j]
//            }
//        }
//    }
//
//    return dp[weights.count][capacity]
//
//}

//maxProfitKnapsack( [2, 3, 4, 5], [3, 4, 5, 6], 6 )


// MARK: -  Subset sum Problem

//func subset(_ arr: [Int], _ sum: Int) ->  Bool {
//    var dp = Array(repeating: Array(repeating: false, count: sum + 1), count: arr.count + 1)
//
//    for i in 0..<arr.count+1 {
//        for j in 0..<sum+1 {
//            if j == 0 {
//                dp[i][j] = true
//            }
//        }
//    }
//    for i in 1..<arr.count+1 {
//        for j in 1..<sum+1 {
//            if arr[i-1] <= j {
//                dp[i][j] = dp[i-1][j-arr[i-1]] || dp[i-1][j]
//            }else {
//                dp[i][j] = dp[i-1][j]
//            }
//        }
//    }
//    return dp[arr.count][sum]
//}
//subset([2,3,7,8,10], 19)

// MARK: - Equal Sum Partioning
//func canPartition(_ nums: [Int]) -> Bool {
//    let sum = nums.reduce(0, +)
//    if sum%2 == 0 {
//        return subset(nums, sum/2)
//    }else {
//        return false
//    }
//}


// MARK: -  count of Subsets for a given sum
//func countSubset(_ arr: [Int], _ sum: Int) ->  Int {
//    var dp = Array(repeating: Array(repeating: 0, count: sum + 1), count: arr.count + 1)
//
//    for i in 0..<arr.count+1 {
//        for j in 0..<sum+1 {
//            if j == 0 {
//                dp[i][j] = 1
//            }
//        }
//    }
//    for i in 1..<arr.count+1 {
//        for j in 1..<sum+1 {
//            if arr[i-1] <= j {
//                dp[i][j] = dp[i-1][j-arr[i-1]] + dp[i-1][j]
//            }else {
//                dp[i][j] = dp[i-1][j]
//            }
//        }
//    }
//    return dp[arr.count][sum]
//}


// MARK: -  Minimum Subset Sum Difference
//func subsetRange(_ arr: [Int], _ sum: Int) ->  [Bool] {
//    var dp = Array(repeating: Array(repeating: false, count: sum + 1), count: arr.count + 1)
//
//    for i in 0..<arr.count+1 {
//        for j in 0..<sum+1 {
//            if j == 0 {
//                dp[i][j] = true
//            }
//        }
//    }
//    for i in 1..<arr.count+1 {
//        for j in 1..<sum+1 {
//            if arr[i-1] <= j {
//                dp[i][j] = dp[i-1][j-arr[i-1]] || dp[i-1][j]
//            }else {
//                dp[i][j] = dp[i-1][j]
//            }
//        }
//    }
//    return dp[arr.count]
//}
//
//func minSubsetSumDiff(_ arr: [Int]) -> Int {
//    var sum = arr.reduce(0, +)
//    var lastRowArr = subsetRange(arr, sum)
//    var sumArr = [Int]()
//    for index in 0..<lastRowArr.count/2 {
//        if lastRowArr[index] == true {
//            sumArr.append(index)
//        }
//    }
//
//    var minimize = Int.max
//
//    for value in sumArr {
//        minimize = min(minimize, sum-2*value)
//    }
//
//    return minimize
//}
//
//minSubsetSumDiff([3,9,7,3])


// MARK: - Minimize Sum Difference
//func subsetRange(_ arr: [Int], _ sum: Int) ->  [Bool] {
//        var dp = Array(repeating: Array(repeating: false, count: sum + 1), count: arr.count + 1)
//
//        for i in 0..<arr.count+1 {
//            for j in 0..<sum+1 {
//                if j == 0 {
//                    dp[i][j] = true
//                }
//            }
//        }
//        for i in 1..<arr.count+1 {
//            for j in 1..<sum+1 {
//                if arr[i-1] <= j {
//                    dp[i][j] = dp[i-1][j-arr[i-1]] || dp[i-1][j]
//                }else {
//                    dp[i][j] = dp[i-1][j]
//                }
//            }
//        }
//        return dp[arr.count]
//    }
//
//
//    func minimumDifference(_ nums: [Int]) -> Int {
//        var sum = nums.reduce(0, +)
//        var lastRowArr = subsetRange(nums, sum)
//        var sumArr = [Int]()
//        for index in 0..<lastRowArr.count/2 {
//            if lastRowArr[index] == true {
//                sumArr.append(index)
//            }
//        }
//
//        var minimize = Int.max
//
//        for value in sumArr {
//            minimize = min(minimize, sum-2*value)
//        }
//
//        return minimize
//    }
//
//minimumDifference([3,9,7,3])

//MARK: -  Count no. of subset with a given difference
//MARK: -  Targer Sum
//
//func countSubset(_ arr: [Int], _ sum: Int) ->  Int {
//    var dp = Array(repeating: Array(repeating: 0, count: sum + 1), count: arr.count + 1)
//
//    for i in 0..<arr.count+1 {
//        for j in 0..<sum+1 {
//            if j == 0 {
//                dp[i][j] = 1
//            }
//        }
//    }
//    for i in 1..<arr.count+1 {
//        for j in 1..<sum+1 {
//            if arr[i-1] <= j {
//                dp[i][j] = dp[i-1][j-arr[i-1]] + dp[i-1][j]
//            }else {
//                dp[i][j] = dp[i-1][j]
//            }
//        }
//    }
//    return dp[arr.count][sum]
//}
//
//func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
//
//    let sumArr = nums.reduce(0, +)
//
//    let sum1 = (target+sumArr)/2
//
//    return countSubset(nums, sum1)
//
//}
//
//findTargetSumWays([1,2,3,1,2], 1)



// MARK: - Longest common Sub Sequence

//func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
//    let m = text1.count, n = text2.count
//    let arr1 = Array(text1), arr2 = Array(text2)
//
//    // DP table to store LCS lengths
//    var dp = Array(repeating: Array(repeating: -1, count: n + 1), count: m + 1)
//
//    // Initialization similar to base condition
//    for i in 0..<m+1 {
//        for j in 0..<n+1 {
//            if i == 0 || j == 0 {
//                dp[i][j] = 0
//            }
//        }
//    }
//
//    for i in 1..<m+1 {
//        for j in 1..<n+1 {
//            if arr1[i-1] == arr2[j-1] {
//                dp[i][j] = 1 + dp[i-1][j-1]
//            }else {
//                dp[i][j] = max(dp[i][j-1], dp[i-1][j])
//            }
//        }
//    }
//    return dp[m][n]
//}
//
//longestCommonSubsequence("abcde", "ace") //3


// MARK: - Longest Common SubString

//func longestCommonSubString(_ text1: String, _ text2: String) -> Int {
//    let m = text1.count, n = text2.count
//    let arr1 = Array(text1), arr2 = Array(text2)
//
//    // DP table to store LCS lengths
//    var dp = Array(repeating: Array(repeating: -1, count: n + 1), count: m + 1)
//
//    // Initialization similar to base condition
//    for i in 0..<m+1 {
//        for j in 0..<n+1 {
//            if i == 0 || j == 0 {
//                dp[i][j] = 0
//            }
//        }
//    }
//
//    var res = 0
//    for i in 1..<m+1 {
//        for j in 1..<n+1 {
//            if arr1[i-1] == arr2[j-1] {
//                dp[i][j] = 1 + dp[i-1][j-1]
//                res = max(res, dp[i][j])
//            }else {
//                dp[i][j] = 0
//            }
//        }
//    }
//    return res
//}

//longestCommonSubString("ABCDGH", "ACDGHR")


//MARK: - Prefix Sum - Longest Subarray with sum k in swift
//To find the longest subarray with sum k in Swift, you can use a prefix sum approach with a dictionary (hashmap) //to store the first occurrence of each prefix sum. This solution runs in O(n) time.

//func longestSubarrayWithSum(_ nums: [Int], _ k: Int) -> Int {
//    var prefixSum = 0
//    var maxLength = 0
//    var sumIndices: [Int: Int] = [:]  // Stores first occurrence of each prefix sum
//
//    for (index, num) in nums.enumerated() {
//        prefixSum += num
//
//        // If sum equals k from start to current index
//        if prefixSum == k {
//            maxLength = index + 1
//        }
//
//        // If (prefixSum - k) exists, we found a subarray
//        if let prevIndex = sumIndices[prefixSum - k] {
//            maxLength = max(maxLength, index - prevIndex)
//        }
//
//        // Store first occurrence of the prefix sum
//        if sumIndices[prefixSum] == nil {
//            sumIndices[prefixSum] = index
//        }
//    }
//
//    return maxLength
//}
////
//let arr = [1, 2, 3, -1, 1, 1, 1, 2]
//let k = 5
//print(longestSubarrayWithSum(arr, k))


//MARK: - Prefix Sum - Longest Subarray with sum k in swift (Only with positive number):
//This can be done using Sliding window

//func subarraySum(_ nums: [Int], _ k: Int) -> Int {
//    var l = 0 ,r = 0
//    var sumCount = 0
//    var sum = 0
//    var maxLen = 0
//
//    while(r<nums.count) {
//        sum = sum + nums[r]
//
//        while sum>k && l<r {
//            sum = sum - nums[l]
//            l = l + 1
//        }
//
//        if sum == k {
//            maxLen = max(maxLen, r-l+1)
//        }
//        r = r + 1
//    }
//    return maxLen
//}
//subarraySum([1,2,3,1,1,1,1], 3)

// Helper to get prime factors



// MARK: - Date 23 Aug
//
//var arr = [1,4,2,1,7,4,6,9,3,5]
////var arr = [1,2,3,1,1,1,1,4,2,3]
//
//var subArr = [[Int]]()
//var maxLen = Int.min
//
//for i in 0..<arr.count {
//
//    var internalSub  = [Int]()
//    for j in i..<arr.count {
//        internalSub.append(arr[j])
//
//        if internalSub.reduce(0, +) == 3 {
//            maxLen = max(maxLen, internalSub.count)
//            subArr.append(internalSub)
//
//        }
//    }
//}
//
//print(subArr)
//print(maxLen)
//
//
//func maxArea(_ height: [Int]) -> Int {
//    var maxArea = Int.min
//    var l = 0
//    var r = height.count-1
//
//    while(l<r) {
//        let length = min(height[l], height[r])
//        let breadth = r-l
//        maxArea = max(maxArea, length*breadth)
//        if height[l] > height[r] {
//            r -= 1
//        } else {
//            l += 1
//        }
//    }
//
//    return maxArea
//}
//
//
////3 Sum
//
//var arr = [1,4,2,1,7,4,6,9,3,5]
////var arr = [1,2,3,1,1,1,1,4,2,3]
//
//var subArr = [[Int]]()
//var maxLen = Int.min
//
//for i in 0..<arr.count {
//
//    var internalSub  = [Int]()
//    for j in i..<arr.count {
//        internalSub.append(arr[j])
//
//        if internalSub.reduce(0, +) == 3 {
//            maxLen = max(maxLen, internalSub.count)
//            subArr.append(internalSub)
//
//        }
//    }
//}


// MARK: 57. Insert Interval

//func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
//    if intervals.isEmpty {
//        return [newInterval]
//    }
//
//    var result = [[Int]]()
//    var isInserted = false
//    var newInterval = newInterval  // So we can modify it if needed
//
//    for interval in intervals {
//        // If current interval is completely before newInterval
//        if interval[1] < newInterval[0] {
//            result.append(interval)
//        }
//        // If current interval is completely after newInterval
//        else if interval[0] > newInterval[1] {
//            if !isInserted {
//                result.append(newInterval)
//                isInserted = true
//            }
//            result.append(interval)
//        }
//        // Overlapping case
//        else {
//            newInterval[0] = min(newInterval[0], interval[0])
//            newInterval[1] = max(newInterval[1], interval[1])
//        }
//    }
//
//    // If newInterval was never inserted, append it at the end
//    if !isInserted {
//        result.append(newInterval)
//    }
//
//    return result
//}


//insert([[1,2],[3,5],[6,7],[8,10],[12,16]], [4,8])
//insert([[1,3],[6,9]], [2,5])


// Cookie Assign:

//func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
//
//    var cookie = s.sorted()
//    var child = g.sorted()
//
//    var p = 0
//    var c = 0
//    var contentChild = 0
//
//    while(p<cookie.count && c<child.count) {
//        if cookie[p]>=child[c] {
//            p += 1
//            c += 1
//            contentChild += 1
//        } else {
//            p += 1
//        }
//    }
//    return contentChild
//}
//
//
//func lemonadeChange(_ bills: [Int]) -> Bool {
//    var noFive = 0
//    var noTen = 0
//    var noTwenty = 0
//    var i = 0
//
//    while(i<bills.count) {
//        var total = (noFive*5) + (noTen*10) + (noTwenty*20)
//
//        if bills[i] == 5 {
//            noFive += 1
//        }
//        else if bills[i] == 10 {
//            noTen += 1
//        }
//        else if bills[i] == 20 {
//            noTwenty += 1
//        }
//
//
//        if total >= bills[i]-5 {
//            if bills[i] == 10 {
//                noFive -= 1
//            }
//            if bills[i] == 20 {
//                if noTen >= 1 && noFive >= 1{
//                    noTen -= 1
//                    noFive -= 1
//                }else if noFive >= 3{
//                    noFive -= 3
//                }else {
//                    return false
//                }
//            }
//
//            i += 1
//        }else {
//            return false
//        }
//    }
//
//    return true
//}
//
//
//func canJump(_ nums: [Int]) -> Int {
//
//    var minReach = Int.max
//    func jump(index: Int, _ steps: Int) {
//        // case when reach beyound destination
//        if index > nums.count-1 {
//            return
//        }
//
//        // case when reach destination
//        if index == nums.count-1 {
//            print(steps)
//            minReach = min(minReach, steps)
//            return
//        }
//        var actual = nums[index]
//        for i in 1...actual {
//
//            jump(index: index+i, steps+i)
//
//        }
//        return
//    }
//
//    jump(index: 0, 0)
//    return minReach
//}
//
//
//canJump([2,3,1,1,4])
//
//
//
//func jump(_ nums: [Int]) -> Int {
//    func jump(_ index: Int, _ steps: Int) -> Int {
//        if index >= nums.count-1 {
//            print(steps)
//            return steps
//        }
//        var actual = nums[index]
//        var minReach = Int.max
//        for i in 1...actual {
//
//            minReach = min(minReach, jump(index+i, steps+i))
//
//        }
//        return minReach
//    }
//
//    return jump(0,0)
//}
//


// MARK: -  VVIMP You have given several meeting in a room, Maximize meetings in one room.


//Idea : Greedy, check which meeting will finish first(endtime). and sort on basis of endTime.
//same As  leet code :435
//func maximumMeetingsInOneRoom(_ start: [Int], _ end: [Int]) ->Int {
//    var meeting = [(start:Int, end:Int, postion:Int)]()
//
//    for i in 0..<start.count {
//        meeting.append((start[i], end[i], i))
//    }
//
//    let roomSort = meeting.sorted { $0.end < $1.end }
//
//    print(roomSort)
//
//    var meetingCount = 1
//    var endTime = roomSort[0].end
//
//    for i in 1..<roomSort.count {
//
//        if roomSort[i].start > endTime {
//            print(roomSort[i].postion)
//            meetingCount += 1
//            endTime = roomSort[i].end
//        }
//    }
//
//    return meetingCount
//}
//var start = [0,3,1,5,5,8]
//var end =   [5,4,2,9,7,9]
//maximumMeetingsInOneRoom(start, end)


// MARK: - Minimum Meeting Rooms or minimum platoform for trains:

//Idea: Keey on eye on time, and evaluate platform by arr and dept time by sorting them

func minimumMeetingRooms(_ start: [Int], _ end: [Int]) ->Int {
    var starTime = start.sorted()
    var endTime = end.sorted()
    var minimumMettingRoom = 0

    var i = 0
    var j = 0
    var noRoom = 0

    while(i<starTime.count && j<endTime.count) {
        if starTime[i] < endTime[j]{
            noRoom += 1
            i += 1
        } else {
            noRoom -= 1
            j += 1
        }
        minimumMettingRoom = max(minimumMettingRoom, noRoom)

    }

    print(minimumMettingRoom)
    return minimumMettingRoom
}
//var start = [0,3,1,5,5,8] //0,1,3,5,5,8
//var end =   [5,4,2,9,7,9] // 2,4,5,7,9,9
////var start = [900, 945, 955, 1100, 1500, 1800]
////var end = [920, 1200, 1130, 1150, 1900, 2000]
//minimumMeetingRooms(start, end)

//func carPooling(_ trips: [[Int]], _ capacity: Int) -> Bool {
//    var startLocationAndPassenger: [(p:Int, s:Int)] = trips.compactMap {($0[0], $0[1])}.sorted { $0.s < $1.s}
//    var endlocation: [(p:Int, e:Int)] = trips.compactMap {($0[0], $0[2])}.sorted { $0.e < $1.e}
//    var currentCapacity = capacity
//
//    var i = 0
//    var j = 0
//
//    while(i<startLocationAndPassenger.count && j<endlocation.count) {
//        if startLocationAndPassenger[i].s < endlocation[j].e {
//            currentCapacity -= startLocationAndPassenger[i].p
//            if currentCapacity < 0 {
//                return false
//            }
//            i += 1
//        }else {
//            currentCapacity += endlocation[j].p
//            j += 1
//        }
//    }
//
//    return true
//
//}

//var s = "A man, a plan, a canal: Panama"
//var filterString = s.filter{ $0.isLetter || $0.isNumber}.lowercased()
//var filArr = Array(filterString)
//var lastIndex  = filArr.count-1
//var mid =  (filArr.count/2)-1


//func palindrome(_ s: String)-> Bool {
//    //var s = "A man, a plan, a canal: Panama"
//    var filterString = s.filter{ $0.isLetter || $0.isNumber}.lowercased()
//    var filArr = Array(filterString)
//    var lastIndex  = filArr.count-1
//    var mid =  (filArr.count/2)-1
//
//    var index = 0
//
//    while(index <= mid) {
//        if filArr[index] == filArr[lastIndex-index] {
//            index += 1
//            continue
//        } else {
//            return false
//        }
//    }
//
//    return true
//}
//
//palindrome("raceacar is not a palindrome.")
//
//
//func isAnagram(_ s: String, _ t: String) -> Bool {
//    guard !s.isEmpty, !t.isEmpty, s.count==t.count else { return false}
//    var sArr = Array(s)
//    var tArr = Array(t)
//
//    var dicts = [Character:Int]()
//    var dictt = [Character:Int]()
//
//    for i in 0..<s.count {
//        dicts[sArr[i]] = (dicts[sArr[i], default: 0]) + 1
//        dictt[tArr[i]] = (dictt[tArr[i], default: 0]) + 1
//    }
//
//    if dicts == dictt {
//        return true
//    } else {
//        return false
//    }
//}
//
//
//"sad sadvf".replacingOccurrences(of: " ", with: "")
//
//
//func longestPalindrome(_ s: String) -> Int {
//    var maxLen = Int.min
//    var arr = Array(s)
//
//    func allCombination(_ index: Int, _ subArr: [Character]) {
//        print(subArr)
//
//        if index >= arr.count { return }
//        //pick
//        allCombination(index+1, subArr+[arr[index]])
//
//        //Not Pick
//        allCombination(index+1, subArr)
//
//    }
//
//    allCombination(0, [])
//
//    return maxLen
//}
//
//longestPalindrome("shiv")


//func findAnagrams(_ s: String, _ p: String) -> [Int] {
//        var arrS = Array(s)
//        var result = [Int]()
//        var len = p.count-1
//        for i in 0..<arrS.count {
//            if i+len < s.count {
//            if isAnagram(String(arrS[i...i+len]), p) {
//                    result.append(i)
//                }
//            }
//        }
//        return result
//    }
//
//func isAnagram(_ s: String, _ t: String) -> Bool {
//        guard !s.isEmpty, !t.isEmpty, s.count==t.count else { return false}
//        var sArr = Array(s)
//        var tArr = Array(t)
//
//        var dicts = [Character:Int]()
//        var dictt = [Character:Int]()
//
//        for i in 0..<s.count {
//            dicts[sArr[i]] = (dicts[sArr[i], default: 0]) + 1
//            dictt[tArr[i]] = (dictt[tArr[i], default: 0]) + 1
//        }
//
//        if dicts == dictt {
//            return true
//        } else {
//            return false
//        }
//    }
//
////Input: s = "ADOBECODEBANC", t = "ABC"
////Output: "BANC"
//
//var dicts = [Character:Int]()
//var dictp = [Character:Int]()
//
//for ch in "ABC" {
//    dictp[ch, default: 0] += 1
//}
//dictp
//dicts = ["B":1, "A":1, "N":1, "C":1]
//
//let containsAll = dictp.allSatisfy { (key, value) in
//    dicts[key] == value
//}
//
//print(containsAll)
//
//
//
//
//func minWindow(_ s: String, _ t: String) -> String {
//    var r = 0
//    var l = 0
//    var result = ""
//    var minLen = Int.max
//    var arrS = Array(s)
//    var dicts = [Character:Int]()
//    var dictp = [Character:Int]()
//    for ch in t {
//        dictp[ch, default: 0] += 1
//    }
//
//
//    while(r<s.count) {
//
//        dicts[arrS[r], default: 0] += 1
//
//        // Shrink Phase
//
//
//        if (r-l+1) >= t.count {
//            let containsAll = dictp.allSatisfy { (key, value) in
//                dicts[key] == value
//            }
//
//            if containsAll {
//                minLen = min(minLen, r-l+1)
//                result = String(arrS[l...r])
//            }
//
//        }
//        r += 1
//    }
//
//    return result
//}


//1358. Number of Substrings Containing All Three Characters
// Input: s = "abcabc"

// Find  minWindow by tracking lastSeen for a,b,c

//func numberOfSubstrings(_ s: String) -> Int {
//    var count = 0
//    var arr = Array(s)
//    var lastSeen = [-1,-1,-1]
//
//    for i in 0..<arr.count {
//        lastSeen[Int(arr[i].asciiValue! - Character("a").asciiValue!)] = i
//
//        if lastSeen[0] != -1 && lastSeen[1] != -1 && lastSeen[2] != -1 {
//            count = count + (1 + min (lastSeen[0], min(lastSeen[1], lastSeen[2])))
//        }
//
//    }
//    return count
//}


//1636. Sort Array by Increasing Frequency
//func frequencySort(_ nums: [Int]) -> [Int] {
//    var freq = [Int:Int]()
//
//    for i in nums {
//        freq[i, default: 0] += 1
//    }
//
//    var dict = freq.sorted {
//        if $0.value == $1.value {
//            return $0.key > $1.key
//        }
//        return $0.value < $1.value
//    }
//
//    var result = [Int]()
//
//
//    for i in dict {
//        var count = i.value
//
//        for _ in 0..<count {
//            result.append(i.key)
//        }
//    }
//
//    return result
//}
//frequencySort([-1,1,-6,4,5,-6,1,4,1])

//[5,-1,4,4,-6,-6,1,1,1]





//func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
//    var l = 0, r = 0
//    var minLen = Int.max
//    var sum = 0
//
//    while r < nums.count {
//        sum += nums[r]

//        while sum >= target {
//            minLen = min(minLen, r-l+1)
//            sum -= nums[l]
//            l += 1
//        }
//
//        r += 1
//    }
//    return minLen
//}
//
//
//minSubArrayLen(1, [1,4,4])



//func rob(_ nums: [Int]) -> Int {
//    func possibleWayS(_ i:Int) -> Int {
//        if i == 0 { return nums[i] }
//        if i < 0 { return 0 }
//
//        var picked = nums[i] + possibleWayS(i-2)
//        var notpicked = 0 + possibleWayS(i-1)
//
//        return max(picked, notpicked)
//    }
//
//    return possibleWayS(nums.count-1)
//
//}
//
//rob([2,7,9,3,1])


// Memoization
//func rob(_ nums: [Int]) -> Int {
//    var dp = Array(repeating: -1, count: nums.count)
//    func possibleWayS(_ i:Int) -> Int {
//        if i == 0 { return nums[i] }
//        if i < 0 { return 0 }
//
//        if dp[i] != -1 { return dp[i] }
//
//        var picked = nums[i] + possibleWayS(i-2)
//        var notpicked = 0 + possibleWayS(i-1)
//
//        dp[i] = max(picked, notpicked)
//        return dp[i]
//    }
//    return possibleWayS(nums.count-1)
//}
//
//print(rob([2,7,9,3,1]))


// Tabulation
//func rob(_ nums: [Int]) -> Int {
//    var dp = Array(repeating: -1, count: nums.count)
//    // if i < 0 { return 0 }
//
//    dp[0] = nums[0]
//    dp[1] = nums[1]
//
//    for i in 2..<nums.count {
//        var picked = nums[i] + dp[i-2]
//        var notpicked = 0 + dp[i-1]
//        dp[i] =  max(picked, notpicked)
//    }
//    return dp[nums.count-1]
//}
//
//print(rob([2,7,9,3,1]))


// MARK: - Longest Subarray with Sum K
func longestSubArray(_ arr:[Int], k:Int) -> Int {
    var dict:[Int:Int] = [:]
    var psum = 0
    var maxLen = Int.min
    for i in 0..<arr.count {
        psum += arr[i]
        
        if psum == k {
            maxLen = i+1
        }else {
            if let prevIndex = dict[psum-k] {
                maxLen = max(maxLen, i-prevIndex)
            }
        }
        
        //gives maximum distance
        if dict[psum] == nil {
            dict[psum] = i
        }
    }
    
    return maxLen
}

print(longestSubArray([10, 5, 2, 7, 1, -10], k:15))
