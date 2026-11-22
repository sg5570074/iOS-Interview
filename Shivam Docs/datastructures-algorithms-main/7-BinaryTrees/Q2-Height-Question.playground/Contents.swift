import Foundation
import XCTest

/*
 TreeHeight
 https://app.codility.com/programmers/trainings/4/tree_height/
 
 Height is the number of steps to the lowest leaf.
 Length of the longest path.
 Tree with one node has height of zero.
   
                    20
                  /    \
                8        22
              /   \
            4       12
                  /    \
                10      14
 */

class Node {
    var key: Int = 0
    var left: Node?
    var right: Node?
    
    init(_ key: Int) {
        self.key = key
    }
    
    var min: Node {
        if left == nil {
            return self
        } else {
            return left!.min
        }
    }
}

//class Height {
    
   func findHeight(root:Node?) -> Int{
       
       if root?.left == nil && root?.right == nil {
           return 0
       }
    
        
       return max(1 + findHeight(root:root?.left),1 + findHeight(root:root?.right))
    }
    
//}


class Tests: XCTestCase {

//    func testHeightOfZero() {
//        let root = Node(5)
//        XCTAssertEqual(0, root.height())
//    }

    func testHeightOfTwo() {
        let root = Node(5)
        root.left = Node(3)
        root.right = Node(10)
        root.left?.left = Node(20)
        root.left?.right = Node(21)
        root.right?.left = Node(1)
        findHeight(root:root)
        XCTAssertEqual(2, findHeight(root:root))
    }
    
//    func testHeightOfThree() {
//        let tree = Tree(20)
//        tree.l = Tree(8)
//        tree.r = Tree(22)
//        tree.l?.l = Tree(4)
//        tree.l?.r = Tree(12)
//        tree.l?.r?.l = Tree(10)
//        tree.l?.r?.r = Tree(14)
//
//        XCTAssertEqual(3, solution(tree))
//    }
}

// Infrastructure
class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}
let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)
Tests.defaultTestSuite.run()


