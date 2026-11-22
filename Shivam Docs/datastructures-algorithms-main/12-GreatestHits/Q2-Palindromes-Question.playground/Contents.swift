import UIKit

/*
 ___ _      _ _         _
| _ \ |__ _| (_)_ _  __| |_ _ ___ _ __  ___ ___
|  _/ / _` | | | ' \/ _` | '_/ _ \ '  \/ -_|_-<
|_| |_\__,_|_|_|_||_\__,_|_| \___/_|_|_\___/__/

 // Challenge: Detect if a given string is a palindrome.
 // A palindrome is a word that can be spelt the same way forwards and backwards.

 */

//func isPalindrome(_ text: String) -> Bool {
//    var revStr = text.reversed()
//    print(revStr)
//    if text == String(revStr) {
//        return true
//    }else {
//        return false
//    }
//}

func isPalindrome(_ text: String) -> Bool {
    var strCharArr = Array<Character>(text)
    var revStr = ""
    for i in stride(from: text.count-1, through:0, by: -1) {
        print(i)
        revStr.append(strCharArr[i])
    }
    
    if text == revStr {
        return true
    }else {
        return false
    }
    
}

isPalindrome("abba")    // true
isPalindrome("mom")     // true
isPalindrome("dad")     // true
isPalindrome("radar")   // true
isPalindrome("rush")    // false
isPalindrome("yes")     // false
