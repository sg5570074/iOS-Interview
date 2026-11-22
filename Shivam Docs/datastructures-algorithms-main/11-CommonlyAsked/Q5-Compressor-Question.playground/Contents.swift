import UIKit

/*
 ___
/ __|___ _ __  _ __ _ _ ___ ______ ___ _ _
|(__/ _ \ '  \| '_ \ '_/ -_|_-<_-</ _ \ '_|
\___\___/_|_|_| .__/_| \___/__/__/\___/_|
              |_|
 
 // Challenge: Give a string with repeating characters (i.e. "aaabb") write
 // an algorithm that will compress the string down to the character, followed
 // by the number of times it appears in the string (i.e "a3b2").
 // If the compressed string is not smaller than original, return original.

 */

func compress(_ str: String) -> String {
    var textCharArr = Array(str)
    
    var finalResult = ""
    var temp = 0
    var prev:Character = textCharArr[0]

    
    for i in textCharArr {
        
        if i == prev {
          //finalResult.append(i)
          temp = temp + 1
        }else{
            finalResult.append(prev)
            finalResult.append("\(temp)")
            temp = 1
        }
        
        prev = i
        
    }
    finalResult.append(prev)
    finalResult.append("\(temp)")
    return finalResult.count < str.count ? finalResult : str
}

compress("aaabb")           // a3b2
compress("aabb")            // aabb
compress("ab")              // ab
compress("abc")             // abc
compress("zzz")             // z3
compress("aabbaabb")        // aabbaabb (not shorter)
