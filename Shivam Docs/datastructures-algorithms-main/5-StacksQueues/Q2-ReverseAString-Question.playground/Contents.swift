import UIKit

// https://www.fullstack.cafe/interview-questions/stacks

/*
 Giving a String, write a function that reverses the String
 using a stack.
 */

func solution(_ text: String) -> String {
    // Do your work here...
    var arr = Array(text)
    var newArr = [String]()
    for c in arr {
      newArr.append(String(c))
    }
    
    for i in 0..<newArr.count {
        arr[i] = Character(newArr.popLast()!)
    }
    
    return String(arr)
}

func solution1(_ text: String) -> String {
    // Do your work here...
    var existingArray = Array(text)
    var newArray = [Character]()
    for _ in 0..<existingArray.count {
        newArray.append(existingArray.removeLast())
    }


    return String(newArray)
}
solution("abc") // cba
solution("Would you like to play a game?")
