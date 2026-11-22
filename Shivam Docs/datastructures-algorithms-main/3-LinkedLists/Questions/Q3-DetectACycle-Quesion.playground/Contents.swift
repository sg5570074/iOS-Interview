import UIKit

/*
 Detect A Cycle
 https://www.hackerrank.com/challenges/ctci-linked-list-cycle/problem
 https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_Tortoise_and_Hare
 
 A linked list is said to contain a cycle if any node is visited more than once while traversing the list. For example, in the following graph there is a cycle formed when node 5 points back to node 3.
 
        4
      /   \
 1 2 3      5
     \_____/
 
 */

class Node: Hashable {
    var data: Int
    weak var next: Node?
    
    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.data == rhs.data && lhs.next == rhs.next
    }
    
    func hash(into hasher: inout Hasher) {
        // Combine the hash values of the properties you want to use for hashing
        hasher.combine(data)
        hasher.combine(next)
    }
}

func hasCycle(first: Node?) -> Bool {
    // here...
    //print("dictReference")
    var dictReference = [Node:Bool]()
    var node = first
    
    while (node != nil) {
        dictReference[node!] = true
        print(dictReference)
        if dictReference[(node?.next)!] == true {
            print("Cycle Detected")
            return true
        }
        node = node?.next
    }
    
    return false
}

let node5 = Node(5)
let node4 = Node(4)
let node3 = Node(3)
let node2 = Node(2)
let head = Node(1)

head.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
node5.next = node3

hasCycle(first: head)





//MARK: -  Cycle Detection Problem
//class ListNode<T> {
//    var value: T
//    var next: ListNode<T>?
//
//    init(_ value: T) {
//        self.value = value
//    }
//}
//
//func hasCycle<T>(_ head: ListNode<T>?) -> Bool {
//    var slow = head
//    var fast = head
//
//    while fast != nil && fast?.next != nil {
//        slow = slow?.next
//        fast = fast?.next?.next
//
//        if slow === fast {
//            return true // Cycle detected
//        }
//    }
//
//    return false // No cycle found
//}
//
//// Example usage:
//let node1 = ListNode(1)
//let node2 = ListNode(2)
//let node3 = ListNode(3)
//let node4 = ListNode(4)
//
//node1.next = node2
//node2.next = node3
//node3.next = node4
//node4.next = node1 // Creating a cycle
//
//let hasCycleResult = hasCycle(node1)
//print("Has cycle: \(hasCycleResult)") // Output: Has cycle: true


//MARK: -  Using Dictionary
//class ListNode {
//    var value: Int
//    var next: ListNode?
//
//    init(_ value: Int) {
//        self.value = value
//        self.next = nil
//    }
//}
//
//func hasCycle(_ head: ListNode?) -> Bool {
//    var visitedNodes = [ListNode: Bool]() // Dictionary to track visited nodes
//
//    var current = head
//
//    while current != nil {
//        // If the current node is already in the dictionary, it's a cycle.
//        if visitedNodes[current!] != nil {
//            return true
//        }
//
//        // Mark the current node as visited
//        visitedNodes[current!] = true
//
//        // Move to the next node
//        current = current?.next
//    }
//
//    // If we reach the end of the list without finding a cycle, there is no cycle.
//    return false
//}
//
//// Example usage:
//let node1 = ListNode(1)
//let node2 = ListNode(2)
//let node3 = ListNode(3)
//
//node1.next = node2
//node2.next = node3
//node3.next = node1 // Creating a cycle
//
