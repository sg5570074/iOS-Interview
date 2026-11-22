import UIKit

/*
 _   _ ___ _    _  __
| | | | _ \ |  (_)/ _|_  _
| |_| |   / |__| |  _| || |
 \___/|_|_\____|_|_|  \_, |
                      |__/

  Challenge: See if you can replace all the spaces in a a string with the
  ASCII symbol for space '%20'. Assume you are given the length of the final
  string. Hint: Use array of char[].

 */

func urlify(_ url: String, length: Int) -> String {
    var resultArr = Array<Character>(repeating: " ", count: length)
    var charArr = Array(url.trimmingCharacters(in: .whitespaces))
    var pointer = 0
    for i in 0..<charArr.count {
        if charArr[i] != " " {
            resultArr[pointer] = charArr[i]
            pointer = pointer+1
            print(pointer)
        }else {
            resultArr[pointer] = "%"
            resultArr[pointer+1] = "2"
            resultArr[pointer+2] = "0"
            pointer = pointer+3
            print(pointer)
        }
    }
    return String(resultArr)
}

urlify("My Home Page    ", length: 16) // "My%20Home%20Page"

