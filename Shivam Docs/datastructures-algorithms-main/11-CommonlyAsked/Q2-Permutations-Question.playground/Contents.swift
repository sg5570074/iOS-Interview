import UIKit

/*
 ___                   _        _   _
| _ \___ _ _ _ __ _  _| |_ __ _| |_(_)___ _ _  ___
|  _/ -_) '_| '  \ || |  _/ _` |  _| / _ \ ' \(_-<
|_| \___|_| |_|_|_\_,_|\__\__,_|\__|_\___/_||_/__/

 Challenge: Given two strings, check if one is a permutation of the other.
 
 */

func isPermutation(_ text: String, _ perm: String) -> Bool {
    
    guard text.count == perm.count  else {return false}
    
    var textCharArr = Array(text)
    var permCharArr = Array(perm)
    
    var textDict = [Character:Int]()
    var permDict = [Character:Int]()
    
    for i in textCharArr {
        if textDict[i] == nil {
            textDict[i] = 1
        }else {
            textDict[i] = (textDict[i] ?? 0) + 1
        }
    }
    
    for i in permCharArr {
        if permDict[i] == nil {
            permDict[i] = 1
        }else {
            permDict[i] = (permDict[i] ?? 0) + 1
        }
    }
    
    for (key,_) in textDict {
        
        if textDict[key] == permDict[key] {
            continue
        }else {
            return false
        }
    }
    return true
}

isPermutation("abc", "cba") // true
isPermutation("abc", "xyz") // false
isPermutation("abcdda", "addbac") // true
isPermutation("abcdda", "addbah") // false
