import UIKit

/*
 ___
/ _ \ _ _  ___ __ ___ __ ____ _ _  _
|(_) | ' \/ -_) _` \ V  V / _` | || |
\___/|_||_\___\__,_|\_/\_/\__,_|\_, |
                                |__/

  Challenge: There are three types of edits that can be performed on strings:
  - insert a character
  - remove a character, or
  - replace a character.
 
  Given two strings, write a function to check if they are one or zero edits away.

 */


///  Check Answer playground :
func oneAway(_ first: String, _ second: String) -> Bool {
    guard abs(first.count - second.count) <= 1 else {
        return false
    }
    
    var firstCharArr = Array(first)
    var secondCharArr = Array(second)
    
    var firstDict = [Character:Int]()
    var secondDict = [Character:Int]()
    
    for i in firstCharArr {
        if firstDict[i] == nil {
            firstDict[i] = 1
        }else {
            firstDict[i] = (firstDict[i] ?? 0) + 1
        }
    }
    
    for i in secondCharArr {
        if secondDict[i] == nil {
            secondDict[i] = 1
        }else {
            secondDict[i] = (secondDict[i] ?? 0) + 1
        }
    }
   print(firstDict)
    print(secondDict)
    
    var diff = 0
    for (key,_) in firstDict {
        
        if (firstDict[key] == secondDict[key]) {
            
        }else {
            
            if diff > 1 {
                return false
            }
            diff = diff + 1
            print(diff)
        }
    }
   
    if diff > 1 {
        return false
    }
    return true
}

//oneAway("pale", "paleXXXX")     // false
//oneAway("pale", "ple")          // true
//oneAway("pales", "pale")        // true
//oneAway("pale", "bale")         // true
oneAway("pale", "bake")         // false
//oneAway("pale", "bakeerer")     // false
oneAway("abcd", "bake")
