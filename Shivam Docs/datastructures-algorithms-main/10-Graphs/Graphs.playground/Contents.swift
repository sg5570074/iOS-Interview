import Foundation

/*
  ___               _
 / __|_ _ __ _ _ __| |_  ___
| (_ | '_/ _` | '_ \ ' \(_-<
 \___|_| \__,_| .__/_||_/__/
              |_|
 */

struct Queue<T> {
    private var array: [T]
    
    init() {
        array = []
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func add(_ element: T) {
        array.append(element)
    }
    
    mutating func remove() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    func peek() -> T? {
        return array.first
    }
}

struct Stack<T> {
    fileprivate var array = [T]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        return array.popLast()
    }
    
    var top: T? {
        return array.last
    }
}

class Graph {
    var V = 0                       // number of vertices
    var adj = [[Int]]()             // adjacency list
    
    init(_ V: Int) {
        self.V = V
        for _ in 0..<V {
            adj.append([Int]())     // create empty array of adjacency lists
        }
    }
    
    func addEdge(v: Int, w: Int) {
        adj[v].append(w)
    }
    
    // BFS traversal from a given source s
    func BFS(s: Int) -> [Int] {
        
        var result = [Int]()
        
        // Mark all vertices as not visited
        var visited = adj.map { _ in false }
        
        // Create BFS Queue
        var queue = Queue<Int>()
        
        // Mark first vertex as visited and enqueue
        visited[s] = true
        print("Starting at \(s)")
        queue.add(s)
        result.append(s)
        
        while queue.count > 0 {
            let current = queue.remove()!
            print("De-queueing \(current)")
            
            // Get all the adjacent vertices of the current vertex
            // If adjacent has not being visited, mark visited and enqueue
            
            for n in adj[current] {
                if visited[n] == false {
                    visited[n] = true
                    print("Queuing \(n)")
                    queue.add(n)
                    result.append(n)
                }
            }
         }
        
        return result
    }
    
    // DFS traversal from a given source s
    func DFS(s: Int) -> [Int] {
        
        var result = [Int]()
        
        // Mark all vertices as not visited
        var visited = adj.map { _ in false }
        
        // Create DFS Stack
        var stack = Stack<Int>()
        
        // Mark first vertex as visited and enqueue
//        print("Starting at \(s)")
        visited[s] = true
        stack.push(s)
        
        while stack.count > 0 {
            let current = stack.pop()!
//            print("Popping \(current)")
            result.append(current)
            
            // Iterate over all neighbours adding to queue and popping deep as we go
            for n in adj[current] {
                if visited[n] == false {
                    visited[n] = true
//                    print("Pushing - \(n)")
                    stack.push(n)
                }
            }
        }
        
        return result
    }
}

// Need to have as many vertices as you have edges
let g = Graph(8)
g.addEdge(v: 0, w: 1)
g.addEdge(v: 1, w: 4)
g.addEdge(v: 4, w: 6)
g.addEdge(v: 6, w: 0)
g.addEdge(v: 1, w: 5)
g.addEdge(v: 5, w: 3)
g.addEdge(v: 3, w: 0)
g.addEdge(v: 5, w: 2)
g.addEdge(v: 2, w: 7)

print(g.BFS(s: 0))
print(g.DFS(s: 0))

/*
 Graph
               ┌────┐           ┌────┐      ┌────┐
 ┌────────────▶│ 5  │◀──────────▶ 2  │◀─────▶ 7  │
 │             └────┘           └────┘      └────┘
 │                ▲
 │                └─────────┐
 │                          │
 ▼                          ▼
 ┌────┐          ┌────┐     ┌────┐
 │ 1  │◀────────▶│ 0  │◀────▶ 3  │
 └────┘          └────┘     └────┘
 ▲               │
 ▼               ▼
 ┌────┐          ┌────┐
 │ 4  │◀─────────▶ 6  │
 └────┘          └────┘
 
 */

func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var adj = [[Int]]()
    var resultTopological = [Int]()
    var visited = prerequisites.map { _ in false }

    for i in 0..<numCourses {
        adj.append([Int]())
    }

    for i in 0..<prerequisites.count {
        adj[prerequisites[i][0]].append(prerequisites[i][1])
    }

    func dfs(_ s: Int) {
        var stack = [Int]()
        visited[s] = true
        stack.append(s)

        while stack.count > 0 {
            let current = stack.popLast()!
//            print("Popping \(current)")
            resultTopological.append(current)

            // Iterate over all neighbours adding to queue and popping deep as we go
            for n in adj[current] {
                if visited[n] == false {
                    visited[n] = true
//                    print("Pushing - \(n)")
                    stack.append(n)
                }
            }
        }
    }

    for i in 0..<numCourses {
        if !visited[i] {
            dfs(i)
        }
    }

    if resultTopological.count == numCourses {
        return true
    }else {
        return false
    }
}

//MARK: - CBT to MAX HEAP (Heapify)

struct MaxHeap {
    private var heap: [Int]

    init(_ array: [Int]) {
        self.heap = array
        buildMaxHeap()
    }

    // convert CBT array → Max Heap
    private mutating func buildMaxHeap() {
        let start = (heap.count / 2) - 1
        if start < 0 { return }

        for i in stride(from: start, through: 0, by: -1) {
            siftDown(i)
        }
    }

    private mutating func siftDown(_ index: Int) {
        let n = heap.count
        var parent = index

        while true {
            let left = 2 * parent + 1
            let right = left + 1
            var largest = parent

            if left < n && heap[left] > heap[largest] {
                largest = left
            }
            if right < n && heap[right] > heap[largest] {
                largest = right
            }

            if largest == parent { return }

            heap.swapAt(parent, largest)
            parent = largest
        }
    }

    func toArray() -> [Int] {
        heap
    }
}

//let cbt = [3, 5, 9, 6, 8, 20, 10, 12, 18, 9]
let cbt = [20,5,15,7,8,9,12,11,13,6,4]
let maxHeap = MaxHeap(cbt)
print("MAX HEAP")
print(maxHeap.toArray())


// MARK: -  Priority Queue

public struct PriorityQueue<Element> {
    private var heap: [Element] = []
    private let areSorted: (Element, Element) -> Bool

    /// Create either a min-priority or max-priority queue.
    /// - parameter ascending: `true` → Min-Heap, `false` → Max-Heap
    public init(ascending: Bool = true, by areSorted: @escaping (Element, Element) -> Bool) {
        if ascending {
            self.areSorted = areSorted       // min-heap
        } else {
            self.areSorted = { areSorted($1, $0) } // max-heap
        }
    }

    public var isEmpty: Bool { heap.isEmpty }
    public var count: Int { heap.count }

    // MARK: - Insert--> Percolate up karenge
    public mutating func push(_ element: Element) {
        heap.append(element)
        siftUp(from: heap.count - 1)
    }

    // MARK: - Remove top priority element --> percolate down karenge
    public mutating func pop() -> Element? {
        guard !heap.isEmpty else { return nil }
        if heap.count == 1 { return heap.removeFirst() }

        let value = heap[0]
        heap[0] = heap.removeLast()
        siftDown(from: 0)
        return value
    }

    public func peek() -> Element? {
        heap.first
    }

    // MARK: - Heap Operations
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2

        while child > 0 && areSorted(heap[child], heap[parent]) {
            heap.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func siftDown(from index: Int) {
        let n = heap.count
        var parent = index

        while true {
            let left = 2 * parent + 1
            let right = left + 1
            var candidate = parent

            if left < n && areSorted(heap[left], heap[candidate]) {
                candidate = left
            }
            if right < n && areSorted(heap[right], heap[candidate]) {
                candidate = right
            }
            if candidate == parent { return }

            heap.swapAt(parent, candidate)
            parent = candidate
        }
    }
}


var minPQ = PriorityQueue<Int>(ascending: true, by: <)
minPQ.push(10)
minPQ.push(4)
minPQ.push(7)

print(minPQ.pop()!)   // 4


var maxPQ = PriorityQueue<Int>(ascending: false, by: <)
maxPQ.push(10)
maxPQ.push(4)
maxPQ.push(7)

print(maxPQ.pop()!)   // 10


struct Node {
    let id: Int
    let distance: Int
}

var minNodePQ = PriorityQueue<Node>(ascending: true) {
    $0.distance < $1.distance
}

minNodePQ.push(Node(id: 1, distance: 5))
minNodePQ.push(Node(id: 2, distance: 1))

print(minNodePQ.pop()!.distance)  // 1




