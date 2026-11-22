import Foundation
import CoreFoundation
import PlaygroundSupport
import XCTest

PlaygroundPage.current.needsIndefiniteExecution = true

//MARK: -  1. Enums

//enum Days:String {
//    case Monday = "Shivam"
//    case Tuesday
//}
//var day = Days.Monday
//print(day.rawValue)
//rawvalue we can use only when we have any Type Defined.

//switch day {
//case .Monday:
//    print("Momday")
//case .Tuesday:
//    print("Tuesday")
//}

//// Associated Values
//enum Student {
//   case Name(String)
//   case Mark(Int,Int,Int)
//}
//
//var studDetails = Student.Name("Swift 4")te
//var studMarks = Student.Mark(98,97,95)
////
//switch studDetails {
//   case .Name(let studName):
//      print("Student name is: \(studName).")
//   case .Mark(let Mark1, let Mark2, let Mark3):
//      print("Student Marks are: \(Mark1),\(Mark2),\(Mark3).")
//}

//// Raw Value
//enum Month: Int {
//   case January = 1, February, March, April, May, June, July, August,
//      September, October, November, December
//}
//
//let yearMonth = Month.May.rawValue
//print("Value of the Month is: \(yearMonth).")
//
//enum Color: CaseIterable {
//    case red, green, blue
//}
//
//for color in Color.allCases {
//    print("My favorite color is \(color).")
//}

//enum Foo:RawRepresentable {
//    case one
//    case two
//    case three
//    case four
//    init?(rawValue: Int) {
//        self = .one
//    }
//
//    var rawValue: Int {
//        return 1
//    }
//
//}
//print("\(Foo.four.rawValue)")
//print("\(Foo.four)")
//switch Foo.four {
//case .one:
//    print("1")
//case .two:
//    print("2")
//case .three:
//    print("3")
//default:
//    print(">3")
//}


//enum Foo:RawRepresentable {
//    case one
//    case two
//    init?(rawValue: Int) {
//        self = .one
//    }
//
//    var rawValue: Int {
//        return 1
//    }
//
//}
//print(Foo.one)
//print(Foo.two)
//print(Foo.one.rawValue)
//print(Foo.two.rawValue)
//
//let result = Foo.one == Foo.two
//switch Foo.two {
//case .one:
//    print("1")
//case .two:
//    print("2")
//}
//print(result)
//print(Foo.one.rawValue)
//print(Foo.two.rawValue)


// Mutaions in Enums: as enum is value type so mutating keyword is required
//enum State {
//    case on
//    case off
//
//    mutating func toggle() {
//        self = self == .off ? .on : .off
//    }
//}
//
//var state:State = .off
//state.toggle()



//MARK: -  2. Protocols
//The protocol must specify whether the property will be gettable or gettable and settable.
//In Swift, protocols themselves are neither value types nor reference types. However, the behavior of a protocol depends on the type that conforms to it. Same is whith extension


//1> Protocol with properties

//protocol Drawable {
//    var edges:Int {
//      get
//      set
//    }
//    var shape:String { get }
//}

//protocol Vehicle3 {
//    var model: String { get }
//    var color: String { get }
//}

//private struct VehicleFields3 : Vehicle3,Drawable {
//    var model: String
//
//    var color: String
//
//    var edges: Int
//
//    var shape: String
//
//}

//2> optional Protocol
//protocol Opt {
//    func requiredFunc()
//   // func optionalFunc()
//}

//extension Opt {
//    func optionalFunc() {
//        print("optionalFunc")
//    }
//}
//
//struct optionalProtocol :Opt {
//    func requiredFunc() {
//        print("requiredFunc")
//    }
// }
//
//var protocolObj = optionalProtocol()
//protocolObj.optionalFunc()
//protocolObj.requiredFunc()

//@objc protocol option {
//    @objc optional func optionalFunc()
//}
//
//class optionProtocol: option {
//    func optionalFunc() {
//        print("optionalFunc")
//    }
//}
//
//// valid only with class
//var protocolObj = optionProtocol()
//protocolObj.optionalFunc()

//protocol A {
//    func updateA()
//    func updateB()
//}
//
//extension A {
//    func updateA() {
//
//    }
//}
//class AA : A {
//    func updateB() {
//
//    }
//}



//3 optional Protocol with struct if your are modifying same property of struct using func
//protocol Animal {
//    var name: String { get set }
//    var color: String { get set }
//    mutating func makeSound()
//}
//
//class Cat: Animal {
//    var name = "Luna"
//    var color = "gray"
//    func makeSound() {
//        print("Meow!")
//    }
//}
//var catObj = Cat()
//catObj.makeSound()
//
//A lazy var is a property whose initial value is not calculated until the first time it's called
//struct Dog: Animal {
//
//    var name = "Charlie"
//    var color = "black"
//    lazy var temp = {
//        return 4
//    }()
//
//    mutating func makeSound() {
//        self.name = "Shivam"
//        print("Woof!")
//    }
//}
//var dogObj = Dog()
//print(dogObj.name)
//print(dogObj.makeSound())
//print(dogObj.name)

//4> Generic Protocol
//protocol college {
//    associatedtype DataType
//    var name : DataType {get}
//
//    func storeName(name:DataType)
//
//}
//

//struct GetNAme : college{
//    var name: String
//
//    func storeName(name: String) {
//        print("\(name)")
//    }
//    typealias DataType = String
//}
//
//var  name = GetNAme(name: "Shivam")

//5>
//protocol College:AnyObject{
//    func getCollegeName()
//}
//
//class B {
//   weak var collegeDelegate : College?
//
//    func getCollege() {
//        collegeDelegate?.getCollegeName()
//    }
//}
////
//class A : College {
//    func getCollegeName() {
//       print("College Name")
//    }
//
//    func fetchCollegeName() {
//        let bobj = B()
//        bobj.collegeDelegate = self
//        bobj.getCollege()
//    }
//
//}
//
//var a = A()
//a.fetchCollegeName()


//MARK: -  3. Closures

//Capture list: The list of values that you want to remain unchanged at the time the closure is created
//var str = "Hello, World!"
//var myClosure = { [str] in
//print (str)
//}
//str = "next"
//let inc = myClosure
//inc()

//The [str] is a capture list. It means: "capture the current value of str at the time this closure is defined."


//func squareNo(number:Int?,completion:(Int)->(Int)) {
//    guard let num = number else {
//       return
//    }
//    let square = num*num
//    print(square)
//   print(completion(square))
//}
//
//squareNo(number: 9) { square in
//
//print("Square is \(square)")
//    return 11
//}
//
//
//
//var clo: ()-> () = {
//
//    print("Hello")
//}
//clo()
//
//
//var myClosure = {
//    print("This is not clousre, bcz if you will change myClosure it will not change")
//}()
//print(myClosure)


//let closure: (Int, Int) -> Int = { (number1, number2) in
//return number1 + number2
//}
//closure(8,2) // the result is 10
//
//
//var shortHandClosure:(Int,Int)->Int = {
//return $0 + $1
//}
//shortHandClosure(8,2) // result is 10



//If there are multiple lines of code inside the closure body, then we cannot omit the return statement.
//var superShortClosure:(Int,Int)->Int = {$0 + $1}


//
//var cloOnePAram: (_ a:Int) -> () = {
//    a in
//    print(a)
//}
//
//cloOnePAram(1)



//MARK:  - 4. GCD

//Question:1 Here Serial Queue with async task : So oder will be maintain
//DispatchQueue.main.async{
//    print("1")
//    //This schedules another block to be run later on the main queue. As its added in a main queue.
//    //2 is queued after 1 but won't execute until the current block (which includes the sleep) completes.
//    DispatchQueue.main.async {
//        print("2")
//    }
//    sleep(3)
//    print("3")
//
//}


//Question:2 https://ersoya.medium.com/dispatch-barrier-in-swift-5613589ce53e#:~:text=Add%20a%20sync%20task%20with,will%20start%20until%20it%20finishes.
/*In a serial queue, tasks run one by one. The next task won’t be kicked off until the previous one is finished

In a concurrent queue, tasks are also run one by one. However, each task is executed on a separate thread, and the queue doesn’t wait for the previous task to run the next one. The next task immediately starts if it’s enough resources for having one more thread
 
 A task can be added to any queue in two ways: sync and async

 When adding a task via the method sync, the current thread gets blocked until the task is finished — no matter whether the queue is serial or concurrent
 
 When using the method async, the current thread conversely proceeds execution immediately after adding the task

 The current thread itself can be main, or one more serial or concurrent queue
 */

// barrier is using in concurrent environment. It is a group of functions acting as a serial queue style objects when working with concurrent queue
//barrier waits for all previously submitted async tasks to complete, and then executes exclusively.

//let queue = DispatchQueue(label: "FirstQueue.com",attributes: .concurrent)

//This sycn task will block the current thread
//queue.sync {
//
//    for i in 0...11 {
//        print("\(i) Items in First Task")
//    }
//}
//
//queue.async {
//    for i in 0...5 {
//        print("\(i) Items in Second Task")//1
//    }
//
//    queue.async {
//        for i in 0...10 {
//            print("\(i) Items in 7 Task")//2
//        }
//    }
//
//    for i in 0...5 {
//        print("\(i) Items in 5 Task")//3
//    }
//}

//Add a sync task with a flag of .barrier to block other tasks. The tasks(sync, async) assigned before this block will be completed first. Then this task will execute and as it is a sync task no other task will start until it finishes.

//As you can see in the output, the execution of sync and async task started. When we add a new task as a barrier, it stops the execution of others. After finishing the execution of task 3, then task 4 continues to execute.

//barrier waits for all previously submitted async tasks to complete, and then executes exclusively.
//queue.sync(flags:.barrier) {
//
//    for i in 0...20 {
//        print("\(i) Items in Third Task")
//    }
//}
//
//queue.async {
//
//    for i in 0...2 {
//        print("\(i) Items in Fourth Task")
//    }
//}


//Question:3
//DispatchQueue.main.async {
//    print("MAin Queueu")
//}

//Question:4 Here Concurrent Queue with async task
//DispatchQueue.global(qos: .userInitiated).async {
//    print("Outside Queu")
//
//    DispatchQueue.global(qos: .userInitiated).async {
//        print("inside Queu")
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            print("superinside Queu")
//        }
//    }
//
//    DispatchQueue.main.async {
//        print("outside superinside queue")
//    }
//}


// Question5: It will give crash
//Answer : Deadlock

//let serialQueue = DispatchQueue(label: "Serial")
//serialQueue.sync {
//    print("Hello World")
//
//    serialQueue.sync {
//        print("Hi there")
//    }
//}

// Deadlock 2
//let lock1 = NSLock()
//let lock2 = NSLock()
//
//func deadlockExample() {
//    DispatchQueue.global().async {
//        lock1.lock()
//        sleep(1)
//        lock2.lock()
//
//        print("Thread 1")
//
//        lock2.unlock()
//        lock1.unlock()
//    }
//
//    DispatchQueue.global().async {
//        lock2.lock()
//        sleep(1)
//        lock1.lock()
//
//        print("Thread 2")
//
//        lock1.unlock()
//        lock2.unlock()
//    }
//}
//
//deadlockExample()

//let queue = DispatchQueue(label: "")
//queue.async {
//    //sleep(2)
//    print("1")
//}
//queue.sync {
//    print("2")
//}
//O/p will be 1 2


// Target Queue :

// async means it will not block the current execution and move further but add task block in that queue
//let a = DispatchQueue(label: "A") //Serial
//let b = DispatchQueue(label: "b", attributes: .concurrent)
//a.async {
//    for i in 0...5 {
//        print(i)
//    }
//}
//a.async {
//    for i in 6...10 {
//        print(i)
//    }
//}
//b.async {
//    for i in 11...15 {
//        print(i)
//    }
//}
//b.sync {
//    for i in 16...20 {
//        print(i)
//    }
//}
//print("kjxgsf")


//let a = DispatchQueue(label: "A") //Serial
//let b = DispatchQueue(label: "b", attributes: .concurrent, target: a) // Now b will act as a serial queue as its inherited from its parent thread, will and get attached into a . This is called Target Queue
//a.async {
//    for i in 0...5 {
//        print(i)
//    }
//}
//a.async {
//    for i in 6...10 {
//        print(i)
//    }
//}
//b.async {
//    for i in 11...15 {
//        print(i)
//    }
//}
//b.sync {
//    for i in 16...20 {
//        print(i)
//    }
//}

//let queue = DispatchQueue.global()
//queue.async {
//
//    for i in 0...10 {
//        print("First\(i)")
//    }
//}
//
//queue.async {
//
//    for i in 0...10 {
//        print("Scond\(i)")
//    }
//}
//
//DispatchQueue.global().async {
//    for i in 0...10 {
//        print("third\(i)")
//    }
//}

//*************//No, calling DispatchQueue.global() multiple times does not create separate concurrent queues. Instead, it returns a reference to the same system-wide global concurrent queue.


//MARK: - 5. MVVM

//viewModel.fetcgData() {  [weak self] in
//
//    self.tableView.reloadData()
//
//}
//
// 1
//2
//3
//var str = readLine()
//let rev = str?.reversed()
//print(rev)
//
// Controller



// MARK: - 6. Fibonacii using tuples
//
//func genratFib() ->([Int],Int) {
//    var first = 0
//    var second = 1
//    let noOfTerms = 5
//    var temp = 0
//    var arr: [Int] = []
//    arr.append(first)
//    arr.append(second)
//    for _ in 0..<noOfTerms {
//        temp = first
//        first = second
//        second = temp + second
//        arr.append(second)
//        print(second)
//    }
//// print(arr)
//    let sumOfFib =  arr.reduce(0, {$0 + $1})
//   // print("sumOfFib is \(sumOfFib)")
//    return (arr,sumOfFib)
//}
//
//var tuple =  genratFib()
//var (_,sf) =  genratFib()
//print(sf)
//
//print("Fibonacii Series = \(tuple.0)")
//print("Sum of Fibonacii Series = \(tuple.1)")
//



//MARK: - 7. String Code

//input - acbabcd
//output   a2b2c2d1

//sort mutates the array it is called on so its items are sorted. sorted returns a copy of the array it is called on with the values sorted.

//let arr = ["FOO", "FOO", "BAR", "FOOBAR"]
//var counts: [Character: Int] = [:]
//print(counts["a"] ?? 0 + 1)
//var str = "aaabbbddss"
//str.sorted()
//for item in str {
//    print(counts[item] ?? 0)
//    counts[item] = (counts[item] ?? 0) + 1
//
//}
//let sortDict = counts.sorted { $0.key < $1.key }
//print(sortDict)  // "[BAR: 1, FOOBAR: 1, FOO: 2]"
//
//for (key, value) in sortDict {
//    print("\(key)\(value)", terminator: "")
//}

//var character:Character = ""

//MARK: - 8. Higher Order Functions

//reversed() Syntax
//The syntax of the string reversed() method is:
//
//String(string.reversed()
//Here, string is an object of the String class.

//var arrtemp = [2,2,4,5,6,3,1,4,64,3]
//print(arrtemp.filter{$0 == 2}.count)
//
//
//func revString(str:String) {
//    print(String(str.reversed()))
//    var rev = String(str.reversed())
//    print("Using In built function \(rev)")
//
//    // loop through each character
//    var result = ""
//    for character in str {
//     result = "\(character)" + result
//       // print(result)
//    }
//    print("Using loop 1st method \(rev)")
//
//    var secondResult = [Character]()
//    for index in stride(from: str.count-1, through: 0, by: -1) {
//        secondResult.append(Array(str)[index])
//    }
//    print("Using loop 2nd method \(String(secondResult))")
//    print("Using loop 2nd method \(secondResult)")
//
//}
//
//revString(str: "shivam")

//
//var tempAny = [1,2,3,4,5,"d","shi"] as [Any]
//
//var temp1 = tempAny.map({
//    arr in
//    return arr as? Int
//})
//print(temp1)
//print("\(tempAny.map({$0 as? Int}))")
//
//var temp2 = tempAny.compactMap({
//    arr in
//    return arr as? Int
//})
//print(temp2)
//
//
//var temp = [1,2,3,4,5,0,-1]
//print(temp.map({$0*2}))
//
//print(temp)
//print(temp.filter({
//    $0 % 2 == 0
//}))
//
//print(temp.reduce(0, {$0 + $1}))
//
//print(temp.sorted(by: {$1 > $0}))



//MARK:- Code

//Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.
// Example 1:
//Input: nums = [3,0,1]
//Output: 2


//var nums = [3,0,1]
//var n = 3

//let tempNum = nums.sorted()
//
//for (i,j) in nums.enumerated() {
//
//    if i != j {
//       print("\(i)")
//    }
//}





//IF we are trying to change value of variable vaccinated inside function declared in struct itself, we get the compile time error.
//So here we need to make function mutating to make change value inside structure. Hence the correct code will be:
//struct Cat {
//   private var vaccinated:Bool
// init() {
//      //self.init()
//     vaccinated = false
//   }
//   // Will not work without mutating keyword
//    mutating func vaccinate() {
//       vaccinated = true
//   }
//}
//var cat1 = Cat()
//cat1.vaccinate()

//inout means that modifying the local variable will also modify the passed-in parameters. Without it, the passed-in parameters will remain the same value. Trying to think of reference type when you are using inout and value type without using it. This is also known as copy-in copy-out.

//For example:

//var char1: Character = "a"
//func changeChar( char: inout Character) {
//    char = "b"
//    print(char) // b
//   // print(char1) // b
//}
//changeChar(char:&char1)
//print(char1)
//A good use case will be swap function that it will modify the passed-in parameters.


//var books: [String] = []
//
//func addTitle(_ title: String, to books: inout [String]) {
//    books.append(title)
//    print(books)
//}
//
//addTitle("The Swift Programming Language", to: &books)




//struct Cat : ItemStoring {
//    var items: [String] = []
//
//    mutating func add(item: String) {
//       self.items.append(item)
//       print(items)
//    }
//
//    var name:String = ""
//    var age:Int = 0
//}
//var cat1 = Cat()
//cat1.add(item: "Shivam")
//protocol ItemStoring {
//   // associatedtype DataType
//
//var items: [String] { get set}
//mutating func add(item: String)
//}

//let n1: Int = 1
//let n2: Float = 2.0
//let n3: Double = 3.34
//
//var result = n1 + n2 + n3
//print(result)

//var color = UserDefaults.standard.string(forKey: "themeColor")!




//var a = 6, b = 4, c = 121
//
//a = a+b
//b = a-b
//a = a-b
//
//var rev = 0, remained = 0
//var temp = c
//while(c>0) {
//  remained = c % 10
//  rev = rev*10 + remained
//  c = c/10
//}
//
//if temp == rev {
//    print("Palindrome")
//}
//else {
//    print((rev))
//    print(" not Palindrome")
//}
//
//

//class Increament {
//    var number = 0
//    deinit {
//        print(#function)
//    }
//    lazy var increamentNumber:(Int)->() = { [unowned self] increament in
//        self.number += increament
//        print(self.number)
//    }
//}
//
//
//
//class Decreament {
//    var number = 0
//    deinit {
//        print(#function)
//    }
//    lazy var increamentNumber:(Int)->() = { [unowned self] increament in
//        self.number += increament
//        print(self.number)
//    }
//}
//
//do {
//    var obj = Increament()
//    obj.increamentNumber(3)
//    //NSError(domain: <#T##String#>, code: <#T##Int#>, userInfo: <#T##[String : Any]?#>)
//}

//extension Increament {
//    var temp = 0
//}


//self.self.someProperty

//var view2 = UIView()
//view2.alpha = 0.5
//
//
//var temp = "i love you much"
//var temp2 =  "i much"
//var temp3 = [String]()
//
//   var fisrt = temp.split(separator: " ")
//    var sec  = temp2.split(separator: " ")
//var thid  = temp.components(separatedBy: " ")
//
//fisrt.filter({ str in
//    return str.contains("much")
//})
//print(temp3)
//
//struct C {
//    var a : Int
//}
//
//let a = C(a:5)

//print([1,2,3].map{$0+$0})
//
// class AA{
//func callme() {
//print("Class A called")
//}
//
//
//}
//class B:AA {
//    override func callme() {
//print("Class B called")
//}
//
//}
//let bb:AA = B()
//print(bb.callme())
//



//struct A {
//    var temp = 5
//}
//
//let obj =  A()
//obj.temp = 6



//viewDidload()
//
//viewWillAppear()
//
//viewdidAppear()
//
//viewwillDisAppear()
//
//ViewdidDisAppear()


//class DBHelper {
//
//    static var sharedInstance = DBHelper()
     
//    func updateDB() {
//
//    }
//
//    func fetchRecord() {
//
//    }
//}


//1
//121
//12321
//1234321
//var row = 4
//for i in 1...row {
//
//    for j in 1...i {
//        print(j,terminator: "")
//    }
//    var count = i-1
//    while(count > 0) {
//        print(count,terminator: "")
//        count -= 1
//    }
//    print("")
//
//}



 //    1
 // 1 2 2 1
 //1 2 3 2 1
//1 2 3 4 3 2 1

//var row = 4
//
//for i in 1...row {
//    
//    for _ in 0..<row-i+1 {
//        print(" ",terminator: "")
//    }
//    
//    for j in 1...i {
//        print(j,terminator: "")
//      }
//      var count = i-1
//      while(count > 0) {
//          print(count,terminator: "")
//          count -= 1
//      }
//    print("")
//    
//    
//}








//0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144,

//var first = 0
//var second = 1
//var temp = 0
//var str = [Int]()
//
////print(first)
////print(second)
//str.append(first)
//str.append(second)
//for i  in 0...10 {
//    temp = first +  second
//    str.append(temp)
//    first = second
//    second = temp
//}
//print(str)

//MARK: - 9. Protocol Oriented to make C class as resuable

//protocol orderStorage {
//    func storeOrder()
//}
//
//class C {
//    private var temp : orderStorage
//
//    init(temp:orderStorage) {
//        self.temp = temp
//    }
//}
//
//class A : orderStorage {
//    func storeOrder() {
//
//    }
//
//}
//
//class B : orderStorage {
//    func storeOrder() {
//
//    }
//
//
//}
//
//var cObj = C(temp: A())
//// constructor injection




// 0 0 1 0 1 0

//var arr = [0,0,1,0,1,0]
//var count = 0
//
//for i in 0..<arr.count {
//    if arr[i] == 0 {
//        count += 1
//    }
//}
//
//for i in 0..<count {
//    arr[i] = 0
//}
//
//for i in count..<arr.count {
//    arr[i] = 1
//}
//print(arr)

//var arr = [1, -2, 1, 0, 5]
//var x = 0
//
//for i in 0..<arr.count {
//
//    for j in i+1..<arr.count {
//        if arr[i]+arr[j] == x {
//            print("\(arr[i]) + \(arr[j])")
//        }
//    }
//}


//MARK: - Paytm 1st Round

//      *
//    * * *
//  * * * * *
//* * * * * * *

//var rows = 5
//var j = 0
//for i in 1...rows {
//    for _ in 1...rows+1-i {
//        print(" ",terminator: "")
//    }
//
//    for _ in 1...i {
//        print("*",terminator: "")
//    }
//
//   var j = i-1
//    while(j>=1) {
//        print("*",terminator: "")
//        j -= 1
//    }
//  print("")
//}


//for i in 1...rows {
//    for _ in 1...rows+1-i {
//        print(" ",terminator: "")
//    }
//
//    for j in i...2*i-1 {
//        print("\(j)",terminator: "")
//    }
//
//   var j = 2*i-2
//    while(j>=i) {
//        print("\(j)",terminator: "")
//        j -= 1
//    }
//  print("")
//}


//* * * * * * *
//  * * * * *
//    * * *
//      *




//Write a program to find the missing number in
//[1,2,3,5,5,6]

//var arr = [1,2,3,5,5,6]
//var missNo = 0
//for i in 1...6 {
//
//    if arr[i-1] != i {
//       missNo = i
//        print(missNo)
//        break
//    }
//}

//class Test {
//     var a: Int!
//     var b: Int?
//     var c: Int
//
//    init(_c:Int) {
//        c = _c
//    }
// }

//func test() {
//    print(1)
//
//    defer{
//        print(2)
//    }
//    defer {
//        print(3)
//    }
//
//    defer {
//        print(4)
//    }
//
//    print(5)
//}
//test()
// 1 5 4 3 2



//struct Person {
//var clothes: String
//var shoes: String
//}
//
//let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
//let other = Person(clothes: "Shirt", shoes: "sneakers1")
//var taylorCopy = taylor
//taylorCopy.shoes = "flip flops"
//print(taylor) // T-shirts , sneakers
//print(taylorCopy) // T-shirts , flip flops

//print("*",terminator: "")
//print("2")
//
//print("This is wild", terminator: " ")
//print("world")


//MARK: - 10. Patterns

//var rows = 5
//*
//* *
//* * *
//* * * *
//* * * * *

//for i in 1...rows {
//    for _ in 1...i {
//        print("*",terminator: "")
//    }
//    print("")
//}

//1
//1 2
//1 2 3
//1 2 3 4
//1 2 3 4 5

//for i in 1...rows {
//    for j in 1...i {
//        print(j,terminator: "")
//    }
//    print("")
//}

//A
//B B
//C C C
//D D D D
//E E E E E

//for i in "ABCDE" {
//    for j in "A" {
//        print(j,terminator: "")
//    }
//    print("")
//}

//MARK: - Print String in Multiline

//let banner = """
//          __,
//         (          o   /) _/_
//          `.  , , , ,  //  /
//        (___)(_(_/_(_ //_ (__
//                     /)
//                    (/
//        """
//print(banner)

//let cafe1 = "Cafe\u{301}"
//let cafe2 = "Café"
//print(cafe2.uppercased())
//print(cafe1 == cafe2)
//var name = "RaChel"
////name.insert("a", at:name.startIndex)
//print(String(name.reversed()))
//print(name.lowercased())
//
//for i in name {
//    print(i)
//}


//    func reverseString(_ s: inout [Character]) {
//        let revStr = String(s.reversed())
//        var arrStr = [Character]()
//        print(s)
//         for (i,j) in revStr.enumerated() {
//             //arrStr.append(i)
//             arrStr.insert(j,at:i)
//         }
//        print(arrStr)
//    }
//var chararr:[Character] = ["h","e","l","l","o"]
//reverseString(&chararr)


//MARK: -  lowercased()

//var lowercase = "jhdsAAdfGD"
//lowercase.lowercased()
//for i in lowercase {
//    let char = i.asciiValue
//    print(char)

//    if char!>=65 && char!<=90 {
//        char += 32
//    }
//
//    print(<#T##items: Any...##Any#>)

//}




//func defangIPaddr(_ address: String) -> String {
//    var charArr:Character  = Character(address)
//    var str = ""
//    for (i,j) in address.enumerated() {
//            if j == "." {
//                str = str + "[.]"
//            }else{
//                str = str + String(j)
//            }
//        }
//    return str
//    }
//
//var tempStr = "adsfadg"
//print(tempStr.split(separator:","))
// var tempInt = Int()
//print(tempInt)

//private let imageCache = NSCache<AnyObject, UIImage>()
//imageCache.object(forKey: "iamge Url")
//imageCache.setObject(UIImage(), forKey: "")

//func displayData<Element>(data: Element) {
//  print("Generic Function:")
//  print("Data Passed:", data)
//}
//
//// generic function working with String
//displayData(data: "Swift")
//
//// generic function working with Int
//displayData(data: 5)


//MARK: - AppyPie Round 2

//       1
//      2 3 2
//    3 4 5 4 3
//  4 5 6 7 6 5 4
//5 6 7 8 9 8 7 6 5

//var rowsCount = 10
//
//for i in 1...rowsCount {
//    for _ in 1...rowsCount+1-i  {
//        print(" ",terminator: "")
//    }
//
//    for j in i...2*i-1 {
//        print(j,terminator: "")
//    }
//    var k = 2*i-2
//    while(k>=i){
//        print(k,terminator: "")
//        k = k-1
//    }
//    print("")
//}
//
//var input = "HrfbK"
//var charArray = ("A"..."Z")
//print(charArray)
//
//for i in ("A"..."Z"){
//    print(i)
//}
//print(input.filter{("A"..."Z").contains($0)})
//




//MARK: -  Auriga Round 2
//func addTwoNumbers<T>(a:T,b:T) -> T {
//
//  return a + b
//}
//
//addTwoNumbers(a: "3", b: "4")


//let arr = [2, nil,5,nil, 5,5,5,5,6,6,67,7,7,nil]
//
//let removeNilArr = arr.compactMap{$0}
//
//var tempArr = [Int]()
//
//for i in removeNilArr {
//
//    if !tempArr.contains(i) {
//        tempArr.append(i)
//    }
//}
//
//print(tempArr)


//var histArr = [5, 1, 2, 0, 3, 4]
////*
////*         *
////*       * *
////*   *   * *
////* * *   * *
//
// var count = 6
//
//arr[6][6]
//
//for i --> histArr {
//
//    var count = histArr.count
//    var i = 0
//    while(i<5) {
//
//    }
//
//    for col --> histArr.count {
//
//        arr[col][row] = "*"
//    }
//}
 



//for rows in 0..<histArr.count {
//
//
//    for col in 0..<histArr.count {
//
//        let total = histArr[col]
//        for _ in 1...total {
//            print("*")
//        }
//    }
//
//}
//


//struct Temp {
//    private var a: Int
//    init(_a:Int) {
//        a = _a
//        print(a)
//    }
//}
//
//
//var tempObj = Temp(_a: 9)



//MARK: - Paytm Round 2

//var tempArr = [5,6,7,12,15,5,1,3,8,9,13]
//
//var uniqueArr = [Int]()
//
//for i in tempArr {
//
//    if !uniqueArr.contains(i) {
//        uniqueArr.append(i)
//    }else {
//        print("Duplicate Number is \(i)")
//    }
//}
//
//print(uniqueArr)
//
//var first = Int.min
//var second = -1
//var third = -1
//for i in uniqueArr {
//    if i > first {
//        third = second
//        second = first
//        first = i
//    }else if i > second {
//        third = second
//        second = i
//    }else {
//        third = i
//    }
//}
//print("Third Largest is \(third)")


//var firstLargest = uniqueArr[0]
//for i in 1..<uniqueArr.count {
//
//    if firstLargest < uniqueArr[i] {
//        firstLargest = uniqueArr[i]
//    }
//}
//
//print("Fisrr Largest is \(firstLargest)")


//MARK: - StackGro
// Anagram
//var str1 = "aabc"
//var str2 = "baca"
//
//// Approach 1
//if str1.sorted() == str1.sorted() {
//    print("Anagram")
//}
//
//// Approach 2
//var frequenctStr1:[Character:Int] = [:]
//var frequenctStr2:[Character:Int] = [:]
//
//// Frequency of str 1
//for i in str1 {
//
//    if str1.contains(i) {
//        frequenctStr1[i] =  ( frequenctStr1[i] ?? 0) + 1
//    }
//}
//
//// Frequency of str2
//for i in str2 {
//
//    if str2.contains(i) {
//        frequenctStr2[i] =  ( frequenctStr2[i] ?? 0) + 1
//    }
//}
//
//print(frequenctStr1)
//print(frequenctStr2)
//
//if frequenctStr1 == frequenctStr2 {
//    print("Anargram")
//}
    

//MARK: - Deloitte
//Write a function to find the longest common prefix string amongst an array of strings.
//
// If there is no common prefix, return an empty string "".
//
// Example 1:

// Input: strs = ["flower","flow","flight"]
// Output: "fl"
// Example 2:
//
// Input: strs = ["dog","racecar","car"]
// Output: ""
// Explanation: There is no common prefix among the input strings.
//
// Constraints:
//
// 1 <= strs.length <= 200
// 0 <= strs[i].length <= 200
// strs[i] consists of only lower-case English letters.*/

//func longestCommonPrefix(_ strs: [String]) -> String {
//    // Return an empty string if the input array is empty
//    guard !strs.isEmpty else { return "" }
//
//    // Start with the first string as the prefix
//    var prefix = strs[0]
//
//    // Iterate through the array of strings
//    for str in strs {
//        // Check the prefix against the current string
//        while !str.hasPrefix(prefix) {
//            // Trim the last character from the prefix until it matches
//            prefix = String(prefix.dropLast())
//
//            // If the prefix becomes empty, there's no common prefix
//            if prefix.isEmpty {
//                return ""
//            }
//        }
//    }
//
//    return prefix
//}
//
//longestCommonPrefix(["flower","flow","flight"])
//
//"Hello".hasPrefix("Hello")

//let n = [0,1,2,3,4,5,6,7,8,9]
//let nn = n.sorted{$1>$0}
//print("\(nn)")
//let str = "hello world😍"


//protocol Greet {
//
//  // blueprint of a property
//  var name: String { get }
//
//
//  // blueprint of a method
//  func message()
//}
//
//class Employee {
//
//  // implementation of property
//  var x = 10
//  var y = 20
//
//    var extProperty:Int {
//        get {
//            return x+y
//        }
//        set(newValue){
//            x = newValue + x
//            y = newValue + y
//        }
//    }
//
//
//}
//
//var obj = Employee()
//obj.extProperty = 40
//
//print(obj.extProperty)


//protocol classa {
//   var marks: Int { get set }
//   var result: Bool { get }
//   
//   func attendance() -> String
//   func markssecured() -> String
//}
//
//protocol classb: classa {
//   var present: Bool { get set }
//   var subject: String { get set }
//   var stname: String { get set }
//}
//
//class classc: classb {
//   var marks = 96
//   let result = true
//   var present = false
//   var subject = "Swift 4 Protocols"
//   var stname = "Protocols"
//
//   func attendance() -> String {
//      return "The \(stname) has secured 99% attendance"
//   }
//   func markssecured() -> String {
//      return "\(stname) has scored \(marks)"
//   }
//}

//let studdet = classc()
//studdet.stname = "Swift 4"
//studdet.marks = 98
//studdet.markssecured()
//
//print(studdet.marks)
//print(studdet.result)
//print(studdet.present)
//print(studdet.subject)
//print(studdet.stname)


//MARK: -  DS Algo

//let arr = Array(repeating: "", count: 10 )
//let arr1 = Array<Int>(repeating: 1, count: 10 )
//print(arr)

//var hash1 = ["1":"shivam"]

//print(hash1["2"])

 //InterView Question 1 Roatation to right :
//func rotatingArr(arr:[Int],count:Int) -> [Int] {
//    var newArr = arr
//    for (index,value) in arr.enumerated() {
//        let newPosition = (index + count) % arr.count
//        print(newPosition)
//        newArr[newPosition] = value
//    }
//
//    return newArr
//}
//
//print(rotatingArr(arr: [3,8,9,7,6], count: 3))


//var myArray = [2, 3, 4, 5]
//
//// Append a new element at the beginning of the array
//let newValue = 1
//myArray.insert(newValue, at: 0)
//
//print(myArray) // Output: [1, 2, 3, 4, 5]


//Question 2 : Dashend String


//func solution(_ str:String)->String {
//    var mainStr = str
//    var trimDash = mainStr.replacingOccurrences(of: "-", with: "")
//    var trimSpace = trimDash.replacingOccurrences(of: " ", with: "")
//    var intArray = Array(trimSpace)
//
//    print(intArray)
//    return ""
//}
//solution("123456789")           // 123-456-789
//solution("555372654")           // 555-372-654
//solution("0 - 22 1985--324")    // 022-198-53-24
//
//// Edge cases
//solution("01")                          // 01
//solution("012")                         // 012
//solution("0123")                        // 01-23
//solution("0123       444")              // 012-34-44
//solution("------0123       444")        // 012-34-44


//public func solution(_ A : [String], _ B : [String], _ P : String) -> String {
//    // do your work here
//    var contact = [String]()
//    for (i,num) in B.enumerated() {
//        if num.contains(P) {
//            contact.append(A[i])
//        }
//    }
//    if contact.isEmpty {
//        return "No Contact"
//    }else {
//        contact.sort()
//        print(contact)
//       return contact[0]
//    }
//}
//
//let Aa = ["pim", "pom"]
//let B = ["999999999", "777888999"]
//let P = "88999"
//
//solution(Aa, B, P)   // pom
//solution(["sander", "amy", "ann"], ["12345", "23456", "123"], "1")  // ann
//solution(["ada,", "eva", "leo"], ["1212", "1111", "4444"], "112")   // NO CONTACT
//
//// edge cases
//solution([String](), [String](), "")
//solution(Aa, B, "")



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


//class ListNode:Hashable,Equatable {
//    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
//        return lhs.value == rhs.value ? true : false
//    }
//
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(value)
//    }
//
//    var value: Int
//    var next: ListNode?
//
//    init(_ value: Int) {
//        self.value = value
//        self.next = nil
//    }
//
//
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
//let hasCycleResult = hasCycle(node1)
//print("Has Cycle: \(hasCycleResult)") // Output: Has Cycle: true
//


//closures


//var clos : (String)->String = { str in
//    return "Shivam\(str)"
//}
//
//print(clos("Gupta"))


//<------------------------------- InterView ƒ Start ------------------------>
//MARK: -  Some InterView Tips

// 1> Convert String into Character Array
//var str = "Shivam"
//var charArr = Array(str)

// 2> Convert Character Array to String
//let charArray: [Character] = ["H", "e", "l", "l", "o"]
//let stringFromArray = String(charArray)

// var str = "online,Hub,Burwood"
// var commaseparated = str.components(separatedBy: ",")
// var skdb = str.split(separator: ",")
// var replaceCooma = str.replacingOccurrences(of: ",", with: "")

// joined
//str = commaseparated.joined(separator: ",")

// Array Slicing
//var arr1 = [1,2,3,4,5,6,7]
//print(arr1[..<3])
//print(arr1[3...])
//print(arr1[1...2])


// 3> Create array of any specific length
//var arr = Array<Character>(repeating: " ", count: 7)

//4> Print statement without changing line(\n)
//print("a",terminator: "")
//print("a")

//5>Abs operator
//let number = -5
//let absoluteValue = abs(number) // absoluteValue will be 5

//6> Swift DictionAries doesnot have defined orders
//var dict1 = [String:String]()
//var dict1:[String:String] = [:]
//dict1["addhar"] = "Shivam"
//dict1["pan"] = "Divya"
//print(dict1)

//7> Equatable Protocol
//struct Planet: Equatable {
//    let name: String
//    let radius: Float
//
//}
//let planetOne = Planet(name: "Earth", radius: 6371)
//let planetTwo = Planet(name: "Earth", radius: 6371)
//
//var status = planetOne == planetTwo //true
//print("\(status)")

// If You are using class then you have to override Equatable protocol method.
//class Moon:Equatable {
//    let name: String
//    let radius: Float
//
//    init(name:String,_ radius:Float){
//        self.name = name
//        self.radius = radius
//    }
//    static func == (lhs: Moon, rhs: Moon) -> Bool {
//         return lhs.name == rhs.name && lhs.radius == rhs.radius
//        //return lhs.self == rhs.self
//       }
//}
//
//let MoonOne = Moon(name: "Earth", 6371)
//let MoonTwo = Moon(name: "Earth", 6371)
//MoonOne == MoonTwo //false


//8> Set : Its an unordered seqeunce
//var setArr = Set<Int>()
//setArr.insert(1)

//9> Min
//var min = Swift.min(5, 3)

//10> If you are using contains method for any custome array then you need to confirm Equatable  protocol
//struct Edges:Equatable {
//    var v1:Int
//    var v2:Int
//}
//var edgeArr = [Edges(v1: 2, v2: 3),Edges(v1: 4, v2: 5)]
//edgeArr.contains(Edges(v1: 2, v2: 3))
//
//print("afgsdh")


//11> Used to avoid race condition
//let lock = NSLock()
//lock.lock()
//lock.unlock()


//12> optional Chaining : Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil. Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.

//class Person {
//    var residence: Residence?
//}
//class Residence {
//    var numberOfRooms = 1
//}
//let john = Person()
////john.residence = Residence()
////let roomCount = john.residence!.numberOfRooms
//if let roomCount = john.residence?.numberOfRooms {
//    print("John's residence has \(roomCount) room(s).")
//} else {
//    print("Unable to retrieve the number of rooms.")
//}


//13> Stored Properties of Constant Structure Instances
//struct FixedLengthRange {
//    var firstValue: Int
//    let length: Int
//}
//var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
//rangeOfThreeItems.firstValue = 6
//
//let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6
//Because rangeOfFourItems is declared as a constant (with the let keyword), it isn’t possible to change its firstValue property, even though firstValue is a variable property.

//This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.

// same isn’t true for classes, which are reference types. If you assign an instance of a reference type to a constant, you can still change that instance’s variable properties.


//14> You must always declare a lazy property as a variable (with the var keyword)
//lazy porperty must be initialised at the time of creation

//struct InterviewCandidate {
//    var isiOS:Bool?
//
//    lazy var iOSResumeDescription: String = {
//        return "I am an iOS developer"
//    }()
//    lazy var androidResumeDescription: String = {
//        return "I am an android developer"
//    }()
//}
//
//var person1 = InterviewCandidate()
//person1.isiOS = true
//
//if person1.isiOS! {
//    print(person1.iOSResumeDescription)
//} else {
//    print(person1.androidResumeDescription)
//
//}

//15>
//for index in stride(from: 5, to: 1, by: -1) {
//print(index)
//}
////prints 5, 4, 3, 2
//
//for index in stride(from: 5, through: 1, by: -1) {
//print(index)
//}
////prints 5, 4, 3, 2, 1
///
///
//16> in out parameter in swift
//var num1 = 4, num2 = 10
//// Defining swap function
//func swapValues(_ num1: inout Int,_ num2: inout Int) {
//    let temp = num1;
//    num1 = num2;
//    num2 = temp;
//}
//
//print("Values of num1 and num2 before swapping are: ",num1,num2)
//// calling swap function
//swapValues(&num1, &num2)
//print("Values of num1 and num2 after swapping are: ",num1,num2)

//17>
//tableView.register(UINib(nibName: "CustomCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
//tableView.register(CustomCell.self, forCellReuseIdentifier: "Cell")

//let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as SecondViewController
//self.navigationController.pushViewController(secondViewController, animated: true)


//18> Convert Character into Int
//let ch: Character = "5"
//
//if let num = ch.wholeNumberValue {
//    print(num)   // 5
//}

//OR
//let ch: Character = "7"
//let num = Int(String(ch))!
//print(num)

//<------------------------------- InterView Tips End ------------------------>


// MARK: -  Consoaring.com

//Write the logic and create an output that prints numbers 1-1000. A number
//should be replaced by “Fizz” if divisible by 3, “Buzz” if divisible by 5,
//and “FizzBuzz” if divisible by both 3 and 5.


//for i in 1...1000 {
//
//    if (i%3 == 0) && (i%5 == 0) {
//        print("FizzBuzz")
//    }else if i%5 == 0 {
//        print("Buzz")
//    }else if (i%3 == 0) {
//        print("Fizz")
//    }else {
//        print("\(i)")
//    }
//}


//Write a function ‘function1’ that takes in two integers as
//in-out parameters. It should also take in another function as a parameter
//and this function should swap the values of the two integers passed.
//Finally ‘function1’ should return two strings “Var1 is now \(var1)” and
//“Var2 is now \(var2)”.

//func function1(number1: inout Int, number2: inout Int) {
//
//    let temp = number1
//    number1 = number2
//    number2 = temp
//
//}
//
//func anotherFunc(num1:Int,num2:Int) {
//    var num11 = num1
//    var num22 = num2
//    function1(number1: &num11, number2: &num22)
//
//    print(num11)
//    print(num22)
//}
//anotherFunc(num1: 10, num2: 12)



//Create a structure with a stored property ‘number’ and a
//computed property ‘numberSquared’ which is computed as the square of
//the stored property. Also declare a getter and setter for ‘numberSquared’.
//The structure also contains a read only property ‘numberCubed’ which
//cubes the stored property.

//struct Demo {
//    var number:Int
//    var numberSquared:Int {
//        get {
//            return number*number
//        }
//
//        set {
//            number = newValue
//        }
//
//    }
//
//    var numberCubed:Int {
//        return number*number*number
//    }
//
//}
//
//let obj =  Demo(number: 2)
//
//print("\(obj.numberSquared)")
//print("\(obj.numberCubed)")



//Define an enumeration for a traffic signal. The signal must
//cycle between three different states (red, yellow and green) every time its
//next() method is called.


//enum Traffic:Int {
//    case red
//    case yellow
//    case green
//
//}
//
//var state = 0
//func next() {
//
//    if state%3 == 0 {
//        print(Traffic.red)
//    }else if state%3 == 1 {
//        print(Traffic.yellow)
//    }else if state%3 == 2{
//        print(Traffic.green)
//    }
//    state = state + 1
//}
//
//next()
//next()
//next()
//next()


//Create a class called VendingMachine. It must contain
//an array of strings called ‘items’ as a stored property. It must also contain
//a function ‘getItem’ which takes a string and compares it to the items in
//the ‘items’ array. If the item is present, it should print ‘Here you go!’ or
//else it should throw a custom error ‘ItemNotAvailable’.

//class VendingMachine {
//
//    var items = [String]()
//
//    init(itemsArr:[String]){
//      items = itemsArr
//    }
//
//    func getItem(str:String) {
//
//        if items.contains(str){
//            print("Here you go!")
//        }else {
//            print("ItemNotAvailable")
//        }
//    }
//}
//
//
//let vendingObj = VendingMachine(itemsArr: ["shivam","prashant","David"])
//
//vendingObj.getItem(str: "hasdsjafkdl")


//func thirdLargestElement(in array: [Int]) -> Int? {
//    if array.count < 3 {
//        return nil // Not enough elements in the array
//    }
//
//    var firstLargest = Int.min
//    var secondLargest = Int.min
//    var thirdLargest = Int.min
//
//    for number in array {
//        if number > firstLargest {
//            thirdLargest = secondLargest
//            secondLargest = firstLargest
//            firstLargest = number
//        }
//        else if number > secondLargest {
//            thirdLargest = secondLargest
//            secondLargest = number
//        }
//        else if number > thirdLargest {
//            thirdLargest = number
//        }
//    }
//
//    return thirdLargest
//}
//
//// Example usage
//let arr = [12, 5, 32, 9, 43, 2, 35, 15]
//if let thirdLargest = thirdLargestElement(in: arr) {
//    print("The third largest element is: \(thirdLargest)")
//} else {
//    print("Not enough elements in the array to find the third largest.")
//}


//@propertyWrapper
//struct PropertyWrappers {
//
//    var value:String
//    var wrappedValue: String {
//        get {
//          return value
//        }
//
//        set(newValue) {
//
//        }
//    }
//}
//struct Email {
//    @PropertyWrappers var emial:String
//}

//MARK: -  Appentive Company
//func getPairs(arr:[Int],sum:Int) {
//
//    var tempArr = arr
//
//    for i in 0..<tempArr.count {
//
//        for j in i..<tempArr.count {
//
//            if (tempArr[i] + tempArr[j]) == sum && tempArr[i] != tempArr[j] {
//                print("\(tempArr[i]) : \(tempArr[j])")
//            }
//        }
//    }
//}
//getPairs(arr: [1,2,3,4,5], sum: 8)
//getPairs(arr: [2,4,6,8,0,1,12,15,17,13,-3,-5,-7], sum: 12)




//var a1 = [10,20,23]
//print(a1.enumerated())
//
//
//for i in a1.indices {
//    print(a1[i])
//}
//
//for i in 0..<a1.count {
//    print(a1[i])
//}
//var a2 = a1
//a2.append(60)
//var x = a1.count
//
//
//var i:Int = 2
//while i < 100 {
//    i = i*i
//}
//var aa = "shivam"
//aa.prefix(2)
//aa.hasPrefix("sh")

//
//var count = 0 {
//    didSet {
//        
//    }
//}
//
//func sum(_ sa:String) {
//    
//}
//sum("")



//[3,8,4,1,9,4,7,6,2]


//var arr = [3,8,4,1,9,4,7,6,2]
//
//for i in 0..<arr.count {
//
//    for j in i+1..<arr.count {
//
//        if arr[i]>arr[j] {
//            var temp = arr[i]
//            arr[i] = arr[j]
//            arr[j] = temp
//        }
//    }
//}
//
//print(arr)




//class Person :NSObject {
//    @objc dynamic var name:String
//    init(_ name:String) {
//        self.name = name
//    }
//}
//var obj = Person("Shivam")
////KVC :
//obj.value(forKey: "name")
//obj.setValue("fghjk", forKey: "name")
//obj.value(forKey: "name")
//
////KVO: observe changes to properties
//obj.observe(\.name,options: [.new]) { person, value in
//    print(value.newValue)
//}
//obj.name = "Divya"
//obj.name = "Shivam"

//MARK: - Tuples
//var a = 5
//var b = 10
//
////a = a+b
////b = a-b
////a = a-b
//
////(a, b) = (b, a)
//print("After swapping, a = \(a), b = \(b)")
//
//var book = ("The Geo book", 1000)
//
//print("Original Tuple:")
//
//print("Name:", book.0)
//print("Pages:", book.1)
//
//
//book.1 = 1500
//
//print("After Modification:")
//
//print("Name:", book.0)
//print("Pages:", book.1)


//var days = "Wednesday,Friday,Sunday,Sunday,Monday,Tuesday"
//let tempDayWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
//
//let daysArr = days.components(separatedBy: ",")
//
//let sortedDays = daysArr.sorted { day1, day2 in
//    guard let index1 = tempDayWeek.firstIndex(of: day1),
//          let index2 = tempDayWeek.firstIndex(of: day2) else {
//        return false
//    }
//    return index1 < index2
//}
//
//print(sortedDays)


//let x:String?? = .some(nil)
//print(x)
//let outputX = (x ?? "inner") ?? "outer"
//print(outputX)
//let y:String?? = nil // outer optional is nil, so inner optional doesnot exist
//let outputY = (y ?? "inner") ?? "outer"
//let string = "\(x) \(y) \(outputX) \(outputY)"


//var x:Int? = nil
//x? = 10
//var y:Int? = 10
//y? = 5
//var z:Int? = nil
//z = 10
////
//let string = "\(x) \(y) \(z)"

//MARK: - 2025 interviews

//MARK: - Paytm
//Q1> reverse LL without modifying pointers
//class Node {
//    var data:Int
//    var next:Node?
//
//    init(_ data: Int, _ next: Node? = nil) {
//        self.data = data
//        self.next = next
//    }
//}
//
//func printLL(head: Node?) {
//    var node = head
//    var result = [Int]()
//
//    while(node != nil) {
//        result.append(node!.data)
//        node = node?.next
//    }
//    print("Linked list: \(result)")
//}
//
//func reverseLL(node: Node?){
//    var currentNode = node
//    var previousNode:Node?
//
//    while(currentNode != nil) {
//        var nextNode = currentNode?.next
//        currentNode?.next = previousNode
//        previousNode = currentNode
//        currentNode = nextNode
//    }
//
//    head = previousNode!
//}
//
//func reverseWithoutModifying(node: Node?) {
//    if node == nil {
//        return
//    }
//
//    reverseWithoutModifying(node: node?.next)
//    print(node!.data, terminator: " ")
//}
//
//var node5 = Node(5)
//var node4 = Node(4,node5)
//var node3 = Node(3,node4)
//var node2 = Node(2,node3)
//var node1 = Node(1,node2)
//
//var head = node1
//
//printLL(head: head)
//
//reverseWithoutModifying(node: head)
//
//reverseLL(node: head)
//
//printLL(head: head)

//Q2> What is combine? Explain in Layman

//Q3> Heap time complexity to insert element in heap

//Q4> Struct VS Class. How methods are stored in heap in case of class



//MARK: - Ontic

//Q1> find all subsets whose sum equals to target
//func findSubsetsWithTargetSum(arr: [Int], target: Int) -> [[Int]] {
//    var result: [[Int]] = []
//
//    func helper(currentSubset: [Int], index: Int, currentSum: Int) {
//        if currentSum == target {
//            result.append(currentSubset)
//            return
//        }
//
//        if index >= arr.count || currentSum > target {
//            return
//        }
//
//        // Include the current element
//        helper(currentSubset: currentSubset + [arr[index]], index: index + 1, currentSum: currentSum + arr[index])
//
//        // Exclude the current element
//        helper(currentSubset: currentSubset, index: index + 1, currentSum: currentSum)
//    }
//
//    helper(currentSubset: [], index: 0, currentSum: 0)
//    return result
//}
////
//let arr = [3, 5, 2, 1, 7, 9, 4, 6]
//let target = 10
//
//let subsets = findSubsetsWithTargetSum(arr: arr, target: target)
//print("Subsets with sum \(target): \(subsets)")

// Q2> How defers work?
//Swift's defer keyword lets us set up some work to be performed when the current scope exits. For example, you might want to make sure that some temporary resources are cleaned up once a method exits, and defer will make sure that happens no matter how that exit happens.

//func testingMultipleDefer() {
//   defer { print("one") }
//   defer { print("two") }
//   defer { print("three") }
//   print("end of function")
//}
//testingMultipleDefer()

//O/P will be:
//end of function
//three
//two
//one

// Q3> How to set private property of class B using Class A?
//class A {
//    func setTemp1(of b: B, to value: Int) {
//        b.setTemp1(value: value)
//    }
//}
//
//class B {
//    private var temp1: Int
//
//    // Initializer to ensure temp1 is set during object creation
//    init(initialValue: Int) {
//        self.temp1 = initialValue
//    }
//
//    // Provide a method to set the private property
//    func setTemp1(value: Int) {
//        self.temp1 = value
//    }
//
//    // Optionally, provide a method to get the private property
//    func getTemp1() -> Int {
//        return temp1
//    }
//}
//
//// Usage:
//let b = B(initialValue: 0) // Initialize temp1 without a default value
//let a = A()
//
//a.setTemp1(of: b, to: 42) // Modify temp1 using class A
//print("Value of temp1 in B: \(b.getTemp1())") // Output: Value of temp1 in B: 42



// Q4> Find out the error ?
//We can't set any private prorerty from other class. But if we want to read it or accsess we can use private(set) var count: Int = 0

//private(set) var count: Int = 0
//
//The count property is read-only outside the Counter class.
//The private(set) access control modifier means that only the Counter class can modify count. Other classes can read the value of count but cannot write or assign to it.

//class Counter {
//    private(set) var count: Int = 0
//
//    func increment() {
//        count += 1
//    }
//}
//
//class DEMO {
//
//    init() {
//        let counter = Counter()
//        print(counter.count)
//        counter.increment()
//        counter.count = 10
//
//    }
//}

//counter.count = 10 // this lines gives error.

//Q5> What is wrong with below code:
//struct UserData {
//    var id: String?
//    var name: String?
//    var profileUrl: String?
//    var refData: UserData?
//}
//"Value type 'UserData' cannot have a stored property that recursively contains it"




// MARK: -  BHARATPE R1

//class A {
//
//}
//
//extension A {
//    private var name: String {
//        return  "Shivam"
//    }
//}
//
// Here extension with name property uses static dispatch.


//2 . When to use class or structure while creating the model?
// Answer:
//Use class if:
//You Need Reference Semantics:
//
//Multiple references to the same object should point to the same memory.
//Example: A model that needs to be shared across different parts of your app.
//You Need Identity or Lifecycle Management:
//
//When the object’s identity is important, or you need to track its state and lifecycle.
//You Need Inheritance:
//
//Classes allow for inheritance, enabling polymorphic behavior.


//3> When deinit method will be called if we are using any class property inside closure body:
//    --> will deinit method will be called
//    --> if deinit method gets called, does closure will remain inside memory?

//class MyClass {
//    var property = "Hello"
//
//    deinit {
//        print("MyClass deinitialized")
//    }
//
//    func createClosure() -> (() -> Void) {
//        // Capture self strongly (default behavior)
//        return {
//            print(self.property)
//        }
//    }
//
//    func createWeakClosure() -> (() -> Void) {
//        // Capture self weakly to avoid retain cycle
//        return { [weak self] in
//            guard let self = self else { return }
//            print(self.property)
//        }
//    }
//}
//
//var closure: (() -> Void)?
//do {
//    let myClass = MyClass()
//   //closure = myClass.createClosure() // Creates a strong reference cycle
//     closure = myClass.createWeakClosure() // No strong reference cycle
//   // closure?()
//}
// If using createClosure(), `deinit` won't be called
// If using createWeakClosure(), `deinit` will be called

//closure?() // Access the closure; behavior depends on capture type




// MARK: - Uber

//given an array of integers numbers, construct a new array in the following manner:
//--> the 1st element of new array is the 1st element of numbers
//--> the 2nd element of new array is the last element of numbers
//--> the 3rd element of new array is the 2nd element of numbers
//--> the 4th element of new array is the second to last element of numbers
//--> ... and so on, until new array contains all elenemts of number

//func constructNewArray(from numbers: [Int]) -> [Int] {
//    var newArray: [Int] = []
//    let count = numbers.count
//
//    for i in 0..<(count + 1) / 2 {
//        // Add the i-th element
//        newArray.append(numbers[i])
//
//        // Add the (count - i - 1)-th element, if it's not the same as the i-th element (to avoid duplication in the middle)
//        if i != count - i - 1 {
//            newArray.append(numbers[count - i - 1])
//        }
//    }
//
//    return newArray
//}
//
//// Example usage
//let numbers = [1, 2, 3, 4, 5]
//let newArray = constructNewArray(from: numbers)
//print(newArray)



//There exists an infinite number line, you wpuld like to build some blocks and obstacles.
//
//Support two types of operations:
//
//-->[1, x]. Build an obstacle at coordinate X alongs the number line. It is guaranteed that there is no obstacle at coordinate X
//--> [2, x, size]. Check if it is possible to place a block of size sizw which end immediately before x on the number line. For eg if x=6 and size = 2 , this operation checks coordinate 4 and 5 . produces "1" if its possible i.e  there is no obstacles else "0"
//
//Given an array of operations containing both types of operations described abvove, your task is to return a binary string for all [2,x,size]




//func processOperations(_ operations: [[Int]]) -> String {
//    var obstacles: [Int] = []  // Maintain a sorted list of obstacles
//    var result: String = ""
//
//    for operation in operations {
//        if operation[0] == 1 {
//            // Build an obstacle at coordinate x
//            let x = operation[1]
//            // Insert obstacle in sorted order
//            if obstacles.isEmpty || x > obstacles.last! {
//                obstacles.append(x)
//            } else {
//                let position = obstacles.firstIndex(where: { $0 > x })!
//                obstacles.insert(x, at: position)
//            }
//        } else if operation[0] == 2 {
//            // Check if block can be placed
//            let x = operation[1]
//            let size = operation[2]
//            let start = x - size
//            let end = x - 1
//
//            // Binary search for the first obstacle in the range [start, end]
//            if obstacles.contains(where: { $0 >= start && $0 <= end }) {
//                result.append("0") // Obstacle found
//            } else {
//                result.append("1") // No obstacle found
//            }
//        }
//    }
//
//    return result
//}
//
//// Example usage
//let operations = [
//    [1, 3],         // Build obstacle at coordinate 3
//    [2, 6, 2],      // Check if block of size 2 ending at 6 can be placed (4, 5) -> "1"
//    [1, 5],         // Build obstacle at coordinate 5
//    [2, 6, 2],      // Check if block of size 2 ending at 6 can be placed (4, 5) -> "0"
//    [2, 8, 3]       // Check if block of size 3 ending at 8 can be placed (5, 6, 7) -> "0"
//]
//
//let output = processOperations(operations)
//print(output)


//in a highly automated warehouse, a robot is tasked with organizing packages stored in a rectangualr grid. Each command instruct a robot to performa a specifix operations on matrix,
//
//"swapRows r1 r2" : Swap the elements of row r1 with the elelements of r2
//
//"swapcolumn c1 c2"
//
//"reverseRow r"
//
//"reverseColumn c"
//
//"rotate90Clockwise" : roatate the entire matrix 90 degress clockwise
//
//Your task is to implement the sequence of commands on the matrix and return the final state of the matrix as 2D list of integers


//func executeCommands(on matrix: [[Int]], commands: [String]) -> [[Int]] {
//    var matrix = matrix
//
//    for command in commands {
//        let components = command.split(separator: " ")
//        let action = components[0]
//
//        switch action {
//        case "swapRows":
//            if let r1 = Int(components[1]), let r2 = Int(components[2]) {
//                matrix.swapAt(r1, r2)
//            }
//
//        case "swapColumns":
//            if let c1 = Int(components[1]), let c2 = Int(components[2]) {
//                for i in 0..<matrix.count {
//                    matrix[i].swapAt(c1, c2)
//                }
//            }
//
//        case "reverseRow":
//            if let r = Int(components[1]) {
//                matrix[r].reverse()
//            }
//
//        case "reverseColumn":
//            if let c = Int(components[1]) {
//                var column = matrix.map { $0[c] }
//                column.reverse()
//                for i in 0..<matrix.count {
//                    matrix[i][c] = column[i]
//                }
//            }
//
//        case "rotate90Clockwise":
//            let rows = matrix.count
//            let cols = matrix[0].count
//            var newMatrix = Array(repeating: Array(repeating: 0, count: rows), count: cols)
//            for i in 0..<rows {
//                for j in 0..<cols {
//                    newMatrix[j][rows - i - 1] = matrix[i][j]
//                }
//            }
//            matrix = newMatrix
//
//        default:
//            break
//        }
//    }
//
//    return matrix
//}
//
//// Example usage
//let initialMatrix = [
//    [1, 2, 3],
//    [4, 5, 6],
//    [7, 8, 9]
//]
//
//let commands = [
//    "swapRows 0 2",
//    "swapColumns 0 2",
//    "reverseRow 1",
//    "reverseColumn 1",
//    "rotate90Clockwise"
//]
//
//let finalMatrix = executeCommands(on: initialMatrix, commands: commands)
//print(finalMatrix)


//MARK: - Concept of memory in case of computed vs lazy property
//class A {
//    var temp = 10
//    private var ptemp = 11
//
//    var comp:Int {
//        return temp+ptemp
//    }
//
//   lazy var lazyComp:Int = {
//        return temp+ptemp+5
//   }()
//}
////
//var a = A()
//a.comp
//a.lazyComp
//a
//a.temp = 20
//a.comp
//a.lazyComp
//a.lazyComp = 3
//a.lazyComp
//a

//Reasons:
//Memory allocated on object creation: temp, ptemp.
//Memory not allocated:
//   -->comp (computed property; no stored value).
//   -->lazyComp (until it is accessed for the first time).


//extension Array where Element: Comparable {
//
//    func removeDuplicates() -> [Element] {
//        guard !self.isEmpty else { return [] }
//
//        var result:[Element] = []
//
//        self.forEach{ value in
//
//            if (!result.contains(value)) {
//                result.append(value)
//            }
//
//        }
//
//        print("\(Self.self)")
//        print("\(Element.self)")
//
//        return result
//    }
//
//}
//
//[1,2,3,2,1,5].removeDuplicates()

// MARK: -  BHARATPE R2

//1> Why swift is called protocol oriented language?
//Protocols help your class and structure to adhere to a certain set of disciplines and make sure that your class and structure follow those sets of disciplines, in big projects protocols help you to write less tangible code with loose coupling and using protocols you can even write excellent test cases for your code.

//“Less tangible” code is abstract, indirect, or hidden.

//Also instead of using fat protocol we can use small protocols (Interface segregation principal)

// In Swift, protocols themselves are neither value types nor reference types. However, the behavior of a protocol depends on the type that conforms to it. Same is whith extension



//2> How you will write test case for Login Resource file in MVVM?

//func testLoginUser_Success() {
//        // Arrange
//        let mockHttpUtility = MockHttpUtility()
//        let loginResponse = LoginResponse(token: "abc123", userName: "John Doe")
//        mockHttpUtility.resultToReturn = .success(loginResponse)
//
//        let loginResource = LoginResource(httpUtility: mockHttpUtility)
//        let expectation = self.expectation(description: "Login completed")
//
//        // Act
//        loginResource.loginUser(loginRequest: LoginRequest(email: "test@test.com", password: "123456")) { result in
//            switch result {
//            case .success(let response):
//                XCTAssertEqual(response.token, "abc123")
//                XCTAssertEqual(response.userName, "John Doe")
//            case .failure:
//                XCTFail("Expected success, got failure")
//            }
//            expectation.fulfill()
//        }
//
//        // Assert
//        waitForExpectations(timeout: 1, handler: nil)

//        XCTAssertTrue(mockHttpUtility.isPostCalled)
//    }



//3> Why multiple inheritance is not supported in class?
//Bcz of Diamond problem.
//class A {
//    func method() {
//
//    }
//}
//
//class B : A{
//    override func method() {
//
//    }
//}
//
//class C : A {
//    override func method() {
//
//    }
//}
//
//class D: B, C  {
//
//}
// Here in class D does not know, which implementation of that overridden method is to be inherited.




//4> How static and dynamic method dispatch are used in protocols and classes?
//Static Dispatch is supported by both value types and reference types(final Class).
//However, Dynamic Dispatch is supported only by reference types(i.e. Non final Class or protocol method calls)
//By default, protocol methods use dynamic dispatch

//protocol Greetable {
//    func greet() // dynamic dispatch
//}
//
//struct Person: Greetable {
//    func greet() {
//        print("Hello from Person")
//    }
//}
//
//let person = Person()
//person.greet()  // Static dispatch (direct call to Person's greet) Static Dispatch (Compile-time Resolution)

//let greetable: Greetable = Person()
//greetable.greet()  // Dynamic dispatch (This occurs because the type is resolved at runtime via the witness table)


//Example 1: Protocol Requirement (Dynamic Dispatch)
//protocol Greeter {
//    func greet()
//}
//
//class Person: Greeter {
//    func greet() {
//        print("Hello from Person")
//    }
//}
//
//let greeter: Greeter = Person()
//greeter.greet() // Output: "Hello from Person" and Dynamic Dispatch is used


//Example 2: Protocol Extension Method
//When the method is accessed via the protocol type (Greeter), dynamic dispatch is used because the method is declared in the protocol.
//protocol Greeter {
//    func greet()
//}
//
//extension Greeter {
//    func greet() {
//        print("Hello from Protocol Extension")
//    }
//}
//
//class Person: Greeter {
//    func greet() {
//        print("Hello from Person")
//    }
//}
//
//let greeter: Greeter = Person()
//greeter.greet() // Output: "Hello from Person"



//protocol Greeter {}
//
//extension Greeter {
//     //static dispathc
//    func sayHello() {
//        print("Hello from Protocol Extension")
//    }
//}
//
//class Person: Greeter {
//    func sayHello() {
//        print("Hello from Person")
//    }
//}
//
//let greeter: Greeter = Person()
//greeter.sayHello() // Output: "Hello from Protocol Extension"
////Here static Dispatch is used

//Summary:
//Declared in the Protocol: Dynamic dispatch (overridable via witness table). As swift cannot know at compile time
//Only in the Protocol Extension: Static dispatch (not overridable).



//5> How you will implement your own custom higher order function filter?

//extension Array {
//    func customFilter(_ isIncluded: (Element) -> Bool) -> [Element] {
//        var result: [Element] = []
//        for element in self {
//            if isIncluded(element) {
//                result.append(element)
//            }
//        }
//        return result
//    }
//
//    func customMap<T>(_ transform: (Element) -> T) -> [T] {
//        var result: [T] = []
//        for element in self {
//            let vs = transform(element)
//            result.append(vs)
//        }
//
//        return result
//    }
//
//    func customCompactMap<T>(_ transform: (Element) -> T?) -> [T] {
//        var result: [T] = []
//        for element in self {
//            if let vs = transform(element) {
//                result.append(vs)
//            }
//
//        }
//        return result
//    }
//
//    func customReduce<T>(_ initialResult: T, _ nextPartialResult: (T, Element) -> T) -> T {
//        var result = initialResult
//        for element in self {
//            result = nextPartialResult(result, element)
//        }
//        return result
//    }
//
//}
//
//var arr: [Int?] = [2,3,4,5,6,7,8, 10, nil]
//var arr2 = [2,3,4,5,6,7,8, 10]
//var filter = arr.customFilter({ element in
//    return (element ?? 0)%2 == 0
//})
//
//var map = arr2.customMap({$0*2})
//var compactmap = arr.customCompactMap({$0})
//var reduce =  arr2.customReduce(0, { $0 + $1 })
//
//var reduceForm = arr2.customReduce(0) { result, value in
//    result + value
//}
//
//print(reduceForm)
//print(reduce)
//print(filter)
//print(map)
//print(compactmap)



// MARK: - Nykaa (Screening)
//1> Remoce duplicates
//func removeDuplicates(from input: String) -> String {
//    var result: [Character] = []
//
//    for character in input {
//        if !result.contains(character) {
//            result.append(character)
//        }
//    }
//    return String(result)
//}
//
//// Read input
//if let lengthInput = readLine(), let stringLength = Int(lengthInput),
//   let inputString = readLine(), inputString.count == stringLength {
//    let output = removeDuplicates(from: inputString)
//    print(output) // Print the result
//} else {
//    print("Invalid input")
//}


// Using Set
//func removeDuplicates(_ str: String) -> String {
// var orgStr = Array(str)
//  return String(Set(orgStr)) // Set is unordered
//}
//
//print(removeDuplicates("aaabbsdb"))



//2> count of consonants and vowels
//func categorizeCharacters(in input: String) -> (goodConsonants: Int, badConsonants: Int, goodVowels: Int, badVowels: Int) {
//    // Define the categories
//    let goodConsonants = Set("bcdfghjklm")
//    let badConsonants = Set("npqrstvwxyz")
//    let goodVowels = Set("aei")
//    let badVowels = Set("ou")
//
//    // Initialize counters
//    var goodConsonantCount = 0
//    var badConsonantCount = 0
//    var goodVowelCount = 0
//    var badVowelCount = 0
//
//    // Process each character in the input
//    for char in input.lowercased() {
//        if goodConsonants.contains(char) {
//            goodConsonantCount += 1
//        } else if badConsonants.contains(char) {
//            badConsonantCount += 1
//        } else if goodVowels.contains(char) {
//            goodVowelCount += 1
//        } else if badVowels.contains(char) {
//            badVowelCount += 1
//        }
//    }
//
//    // Return the counts
//    return (goodConsonantCount, badConsonantCount, goodVowelCount, badVowelCount)
//}
//
//// Read input
//if let input = readLine() {
//    let counts = categorizeCharacters(in: input)
//    print("\(counts.goodConsonants) \(counts.badConsonants) \(counts.goodVowels) \(counts.badVowels)")
//}



//MARK: -  Nykaa R1
//Custom Implementation of Notification Center

//class CustomNotificationCenter {
//    static let shared = CustomNotificationCenter()
//    private init() {}
//
//    // MARK: - Observer Entry
//    private struct ObserverEntry {
//        weak var observer: AnyObject?
//        let selector: Selector
//    }
//
//    private var observers: [String: [ObserverEntry]] = [:]
//    private let syncQueue = DispatchQueue(label: "com.custom.notificationcenter.sync")
//
//    // MARK: - Add Observer
//    func addObserver(_ observer: AnyObject, selector: Selector, name: String) {
//        syncQueue.sync {
//            let entry = ObserverEntry(observer: observer, selector: selector)
//            if observers[name] == nil {
//                observers[name] = []
//            }
//            observers[name]?.append(entry)
//        }
//    }
//
//    // MARK: - Remove Observer
//    func removeObserver(_ observer: AnyObject, name: String) {
//        syncQueue.sync {
//            observers[name]?.removeAll { $0.observer === observer || $0.observer == nil }
//            if observers[name]?.isEmpty == true {
//                observers.removeValue(forKey: name)
//            }
//        }
//    }
//
//    // MARK: - Post Notification
//    func post(name: String, userInfo: [AnyHashable: Any]? = nil) {
//        syncQueue.sync {
//            guard let entries = observers[name] else { return }
//
//            for entry in entries {
//                guard let observer = entry.observer else { continue }
//                if observer.responds(to: entry.selector) {
//                    _ = observer.perform(entry.selector, with: userInfo)
//                }
//            }
//
//            // Cleanup any nil observers
//            observers[name] = entries.filter { $0.observer != nil }
//        }
//    }
//}


// MARK: -  BHARATPE R3

//What is principle of MVVM?
// The Model-View-ViewModel (MVVM) architectural pattern is based on the principle of separating an application's business logic and user interface (UI)


// MARK: - OYO R1

//Q1>
//protocol A {
//    func method()
//}
//
//extension A {
//    func method() {
//        print("Shji")
//    }
//}
//
//class V: A {
//
//
//}
//
//var obj = V()
//obj.method()

//Answer : Here, the call to obj.method() is resolved to the extension's implementation using static dispatch.If you want dynamic dispatch, you need to make method() a requirement of the protocol and provide a custom implementation in the conforming class:

//Q2>
//class V {
//
//}
//struct stu {
//    var temp = V()
//}
//
//var stuObj = stu()
//var stuObj1 = stuObj
//
//print(stuObj.temp)
//print(stuObj1.temp)
//
//
// print(stuObj.temp === stuObj.temp)

//withUnsafePointer(to: stuObj.temp) { print("stuObj.temp memory address: \($0)") }
//withUnsafePointer(to: stuObj1.temp) { print("stuObj1.temp memory address: \($0)") }
//
//// Print Refernce Type memory location
//Unmanaged.passUnretained(stuObj.temp).toOpaque()
//Unmanaged.passUnretained(stuObj1.temp).toOpaque()

//✅ Key Difference
//
//Class: Unmanaged.passUnretained(obj).toOpaque() → heap address of the instance.
//
//Struct: withUnsafePointer(to: &obj) → address of the struct’s storage (stack or inline in another object).



//Q3>
//class Bike {
//   let name = ""
//   let no: Int = 10
//
//    deinit {
//        print("klm,")
//    }
//}
//func genrateBikeNumber() -> ()->Int {
//   let aBike = Bike()
//   let aNumberBuilder = { [unowned aBike] in
//       return aBike.no * 2
//   }
//   return aNumberBuilder
//}
//let aNumber = genrateBikeNumber()()
//print("My bike number is \(aNumber)")

// Answer: 
//The closure aNumberBuilder is returned from genrateBikeNumber(). However, as soon as genrateBikeNumber() finishes executing, the local variable aBike goes out of scope and gets deallocated.
//The closure still holds a reference to aBike, but because it's an unowned reference, it does not retain aBike. By the time the closure is executed, aBike has already been deallocated.


//Q3>
//o/p:a is 10 b is 30
//var a = 10
//
//var b = 10
//
//let closure = {  [a] in
//
//   print("a is \(a)")
//
//}
//
//a = 40
//
//closure()
//
//b = 30
//print("b is \(b)")


//Q4>
//class MyClass {
//    static let shared = MyClass()
//    var aDict = [String: Int]()
//
//    func readData() {
//        print("Reading data")
//        print("\(String(describing: aDict["key"]))")
//    }
//
//    func writeData() {
//        print("Writing data")
//        self.aDict["key"] = 30
//    }
//}
//
// //Simulating Race Condition
//let sharedInstance = MyClass.shared
//let concurrentQueue = DispatchQueue(label: "com.example.raceCondition", attributes: .concurrent)
//
//var sempahoreWrite = DispatchSemaphore(value: 1)
//var sempahoreRead = DispatchSemaphore(value: 0)
//concurrentQueue.async {
//    for _ in 0..<10 {
//        sempahoreWrite.wait()
//        sharedInstance.writeData()
//        sempahoreRead.signal()
//    }
//}
//
//
//concurrentQueue.async {
//    for _ in 0..<10 {
//       sempahoreRead.wait()
//       sharedInstance.readData()
//       sempahoreWrite.signal()
//    }
//}
//
////// Adding a delay to keep the playground running
//DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    print("Finished")
//}


// printSereis : 1 A 2 B ......... 26 Z
//let semaphoreNumber = DispatchSemaphore(value:1)
//let sempahoreAlphabet = DispatchSemaphore(value:0)
//
//func printNumber() {
//    for i in 1...26 {
//        semaphoreNumber.wait()
//        print("\(i)", terminator: " ")
//        sempahoreAlphabet.signal()
//    }
//}
//
//func printAlphbets() {
//    for i in 0..<26 {
//        sempahoreAlphabet.wait()
//        let letter = Character(UnicodeScalar(65+i)!)
//        print(letter, terminator: " ")
//        semaphoreNumber.signal()
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


// MARK: - OYO R2

//Lib -
//- UIImageView extension
//- Concurrent Downloads
//- In-memory and Disk Caching - Efficient
//- Also, progress values the downloads


//Scalability
//Concurency
//Handling error conditions
//Design Patterns


//1> create frameork customDownlaod

//let image = UIImageView()
//
//image.downloadImage(URL("kjsaakdf"))
//
//
//extension UIImageView{
//
//  //  var cutomDownloader = DownlodManger()
//
//    func downloadImage(_ url: URL?, closure:(DownloadSateTracker, progressValue) -> () {
//
//        DownlodManger.ownloadStart()
//    }
//
//}
//
//class DownlodManger {
//
////    var dict = [URL:DownlodService]()
//
//    func downloadStart() {
//        // downloade
//
//        retunr
//    }
//
//    func downloadComplete() ->
//
//    /// Cache
//    }
//
//
//}
//
//enum DownloadSateTracker {
//
//    case downloading
//    case complete
//    case failure
//
//}
//

//class DownlodService {
//   // DownloadSateTracker
//
//   // DownloadSateTracker
//
//    //Managing Concurrent Downloads
//
//
//
//    // Loop imageURLs
//
//    //DispatchQue.Gloabal
//
//     Data()
//
//      //
//}
//
//
//class caching {
//   / NSCache<image>
//
//    ///disl
//    ///.cache
//    ///
//
//    //filemangw
//}


// MARK: - class func vs static func
//class Parent {
//    class func classMethod() {
//        print("Class method in Parent")
//    }
//
//    static func staticMethod() {
//        print("Static method in Parent")
//    }
//}
//
//class Child: Parent {
//    override class func classMethod() {
//        print("Overridden class method in Child")
//    }
//
//    // ❌ Error: Cannot override a static method
//    // override static func staticMethod() { }
//}
//
//Parent.classMethod()  // Output: Class method in Parent
//Child.classMethod()   // Output: Overridden class method in Child
//
//Parent.staticMethod() // Output: Static method in Parent
//Child.staticMethod()  // Output: Static method in Parent (not overridden)


// MARK: - Seven 11
//1> Explain Core Data Stack
//2> CoreLocation
//3> FireBase implementation
//4> implement Api and shown in list, on click of cell, Navigate to detail Screen



// MARK: - Microsoft
//There are N rectangles numbered from 0 to N-1. The K-th rectangle has size A[K] × B[K].
//We call two rectangles similar when:
//• they share a side of the same length, and
//• the length of the other sides differs by at most 1.
//For example:
//• rectangles 2x3 and 2x4 are similar,
//• rectangles 2x3 and 4x2 are also similar (rectangles can be rotated),
//• rectangles 2x3 and 2x5 are not similar (other sides differ by 2),
//• rectangles 2x2 and 3x3 are not similar either (more than one side differing in length).
//The task is to choose as many rectangles as possible in such a way that every two chosen rectangles are similar to each other. Note that rectangles can be rotated.
//Write a function:
//public fune solution(_ A : inout [Int], - B : inout [Int]) -> Int
//that, given two arrays A and B of N integers each, returns the maximum number of similar rectangles that can be chosen.
//Examples:
//1. Given A = [500, 500] and B = [500, 500], the function should return 2. Both rectangles
//can be chosen.
//2. Given A = [5, 5, 1, 6, 4] and B = [2, 1, 6, 1, 1] the function should return 3. The best
//choice is to take the rectangles in positions 1 to 3. After rotation, their sizes are respectively 5x1, 6x1 and 6x1.
//3. Given A = [3, 3, 3, 3, 5, 7, 1, 1] and B = [4, 6, 8, 10, 10, 10, 2, 3] the function should return 2. The optimal choice is to take last two rectangles (sizes 1x2 and 1x3).
//4. Given A = [4, 4, 2, 2, 2, 4, 4] and B = [3, 4, 6, 6, 6, 3, 4] the function should return 4. The best choice is totake the firsta nd last to rectanges (sizes 3*4, 4*4, 3*4 and 4*4)


//struct Rectangle: Hashable {
//
//    let width: Int
//    let height: Int
//
//    init(_ width: Int, _ height: Int) {
//        self.width = min(width, height)
//        self.height = max(width, height)
//    }
//}
//
//
//public func solution(_ A : inout [Int], _ B : inout [Int]) -> Int {
//    var rectangleGroups = [Rectangle: Int]()
//
//    for i in 0...A.count-1 {
//        let similarRectangle = Rectangle(A[i], B[i])
//
//        rectangleGroups[similarRectangle, default: 0] += 1
//    }
//
//    print(rectangleGroups)
//
//    var maxGroupSize = 0
//
//    for (rectangle, count) in rectangleGroups {
//
//        let similar1 = rectangleGroups[Rectangle(rectangle.width, rectangle.height - 1)] ?? 0
//        let similar2 = rectangleGroups[Rectangle(rectangle.width, rectangle.height + 1)] ?? 0
//
//        maxGroupSize = max(maxGroupSize, count)
//        maxGroupSize = max(maxGroupSize, count + similar1)
//        maxGroupSize = max(maxGroupSize, count + similar2)
//    }
//
//    return maxGroupSize
//}


//var A = [500, 500]
//var B = [500, 500]
//
//print(solution(&A, &B))

//var A = [5, 5, 1, 6, 4]
//var B = [2, 1, 6, 1, 1]
//print(solution(&A, &B))


//public func solution(_ B : inout [String]) -> Int {
//    let N = B.count
//    let M = B[0].count
//
//    let directions = [(1,0), (0,-1), (0,1)]
//
//    func isValid(x: Int, y:Int) -> Bool {
//
//        return x>=0 && x<N && y>=0 && y<M && B[x][B[x].index(B[x].startIndex, offsetBy: y)] == "."
//    }
//
//    if B[0].first == "x" || B[N-1].last == "x" {
//        return -1
//    }
//
//    var queue = [(0,0)]
//    var visited = Array(repeating: Array(repeating: false, count: M), count: N)
//    visited[0][0] = true
//
//    var chamberCount = 1
//
//    while !queue.isEmpty {
//        let (x,y) = queue.removeFirst()
//
//        for (dx, dy) in directions {
//            let nx = x+dx
//            let ny = y+dy
//
//            if isValid(x: nx, y: ny) && !visited[nx][ny] {
//                visited[nx][ny] = true
//                queue.append((nx,ny))
//                chamberCount += 1
//            }
//        }
//    }
//
//    return visited[N-1][M-1] ? chamberCount : -1
//}


// MARK: -  Winzo
//--> Copy in Write for struct : Applicable for value type (struct) in case of array only
// Answer : Only for collections

//--> Autolayout life Cycle
//--> Expalin Static VS Dynamic Framework
//--> Dynamic Linking VC static linking


//func countPairs(_ arr:[Int], sum: Int) {
//    var count = 0
//    for i in 0..<arr.count {
//        for j in i+1..<arr.count {
//            if arr[i] + arr[j] == sum {
//                print("(\(arr[i]), \(arr[j]))")
//                count += 1
//            }
//        }
//    }
//
//    print(count)
//}
//
//func countPairsusingDict(_ arr:[Int], sum: Int) {
//    var dict = [Int:Int]()
//    var count = 0
//    for i in 0..<arr.count {
//        if dict.keys.contains(sum-arr[i]) {
//            print("(\(arr[i]), \(arr[dict[sum-arr[i]]!]))")
//            count += 1
//
//        }
//        dict[arr[i]] = i
//    }
//
//    print(count)
//}
//
//countPairsusingDict([1,5,7,-1,5], sum: 6)


//class Person: NSObject{
//   @objc dynamic var name: String
//    init(name: String) {
//        self.name = name
//    }
//}
//
//var p = Person(name: "Shivam")
//p.value(forKey: "name")
//
//p.observe(\.name, options: [.old, .new]) { peron, value in
//    print(value.newValue)
//    print(value.oldValue)
//}
//
////p.name = "gupta"
//p.setValue("asfd", forKey: "name")


//MARK: -  Winzo R2:

//SetNeedsDisplay() : method tells UIKit to call draw(_:) in the next rendering pass.

//optional closures are escaping or not?

// Life cycle of ViewController

// content huggins vs content compression

//var serial = DispatchQueue(label: "serial")
//
//serial.async {
//
//    for i in  1...10 {
//        print("Shivam")
//    }
//
//    serial.async {
//        for i in  1...10 {
//            print("Gupta")
//        }
//    }
//}
//
//for i in  1...10 {
//    print("Gupta")
//}
// Play above as much as you can with output by changing async , sync and serial tocurrent


// MARK: - Urban

//Urban Company needs to define "hubs" for providing services in a city. A "hub" is a group of connected "localities" in a city. Consider a 2D boolean matrix representing a city where each 1 represents a "locality". A group of connected localities (horizontally or vertically) is defined as a "hub". The task is to find the number of distinct "hubs'' present in a city.  Two "hubs'' are considered to be distinct if and only if one hub is not equal to another (don't consider rotations or reflections).
//
//Input: city[][] =
//{
//{1, 1, 1, 0, 0},
//1, 1, 1, 0, 0},
//0, 0, 0, 1, 1},
//0, 0, 0, 1, 0}
//}
//
//Output: 1
//Hub 1, 1, 1 at the top left corner is same as Hub 1, 1, 1 at the bottom right corner



//MARK: -  LensKart

//let queue = DispatchQueue(label: "queue")
//queue.sync {
//    sleep(2)
//    print("1")
//
//}
//
//queue.async {
//    print("2")
//}
//
//var arr = [1,0,2,3,4,0,5,0] // 5
//
//var noOFZeros = 0 //5
//
//for i in 0..<arr.count {
//    if arr[i]==0 {
//        var index = arr.firstIndex(of: 0)
//        arr.remove(at: index ?? 0)
//        arr.append(0)
//    }
//
//
//}
//
//class A {
//    lazy var a = {
//
//    }()
//}
//
//print(arr)

//var temp = arr.sorted {
//    $0 > $1
//}
//
//print(temp)

//arr.forEach { value in
//    if value == 0 {
//        noOFZeros += 1
//    }
//}
//
//for _ in 1...noOFZeros {
//    var index = arr.firstIndex(of: 0)
//    arr.remove(at: index ?? 0)
//}
//
//
//
//for _ in 1...noOFZeros {
//    arr.append(0)
//}
//
//print(arr)




// MARK: - LensKart R2

//1> order of testcase called
//class MyTestCase: XCTestCase {
//
//    override func setUp() {
//        super.setUp()
//        print("setUp called")
//    }
//
//    override func tearDown() {
//        print("tearDown called")
//        super.tearDown()
//    }
//
//    func testA() {
//        print("testA executed")
//    }
//
//    func testB() {
//        print("testB executed")
//    }
//}
//
//class TestObserver: NSObject, XCTestObservation {
//    func testCase(_ testCase: XCTestCase,
//                  didFailWithDescription description: String,
//                  inFile filePath: String?,
//                  atLine lineNumber: Int) {
//        assertionFailure(description, line: UInt(lineNumber))
//    }
//}
//let testObserver = TestObserver()
//XCTestObservationCenter.shared.addTestObserver(testObserver)
//MyTestCase.defaultTestSuite.run()

//setUp called
//testA executed
//tearDown called
//setUp called
//testB executed
//tearDown called

//2 How to implement custom optionals:
//enum MyOptional<T> {
//    case some(T)
//    case none
//
//    // Unwrap the value safely
//    func unwrap() -> T? {
//        switch self {
//        case .some(let value):
//            return value
//        case .none:
//            return nil
//        }
//    }
//
//    // Provide a default value when nil
//    func value(or defaultValue: T) -> T {
//        switch self {
//        case .some(let value):
//            return value
//        case .none:
//            return defaultValue
//        }
//    }
//}
//
//var a: MyOptional<Int>
//a = .some(7)
//
//print(a.value(or: 4))

//3 How to implement test case for api call




//4 The Difference Between ClipsToBounds(cuts view to go further superview bounds) And MasksToBounds(cuts layers to go further superlayers bound when its true)


//5 Diff bw App Group, App id and Bundle Id
//An App ID is a string used to identify one or more apps from a single development team. The string consists of two parts, the Team ID and the bundle ID separated by a period (.). The Team ID is supplied by Apple, while the bundle ID is supplied by the developer

//An "App Group" in iOS is a feature that allows multiple apps developed by the same team to securely share data and communicate with each other by accessing a shared container

//6 Diff bw left anchor((bad for RTL support)) and leading anchor
//https://medium.com/@iOSifMol/difference-between-leading-and-left-constraints-in-swift-8d60154e78c9


//6 Diff bw float, double,  CGFloat


//7 var arr = [5,4,2,6,9,3,0,1,5,4]

//
//            +
//            +
//            +
//         +  +
//+        +  +        +
//+  +     +  +        +  +
//+  +     +  +  +     +  +
//+  +  +  +  +  +     +  +
//+  +  +  +  +  +  +  +  +

//var arr = [5,4,2,6,4]
//
//var totalWater = 0
//
//var maxHeighPillar = arr.max()
//var maxHeighPillarIndex = arr.firstIndex(of: maxHeighPillar!)
//var minWater = min(arr[0], arr[arr.count-1])
//
////print(minWater)
//
//for i in 0..<arr.count-1 {
//    if arr[i] >  minWater {
//        totalWater += minWater()
//    }
//
//    totalWater += minWater
//}
//
//print("Total Water = \(totalWater)")


//MARK: - NAVI


//--> protocol AnalyticSerViceDelgate : 

//       --> trackEvent(event:Event)
//     -->sendEvents(event:[Event])
//      --> callAnaltyicsSerivde
//
//--> AnlayticsManger : Singleton
//
//--> Events
//
//--> Enum: TypeofEvents


//class Event {
//    var name:TypeofEvents
//    var parameter: [String:String]
//
//    init(name: TypeofEvents, parameter: [String:String]) {
//        self.name = name
//        self.parameter = parameter
//    }
//}
//
//enum TypeofEvents {
//    case buttonTap
//    case apiSuccess
//    case apiFailure
//    case viewLoaded
//    case apiLatency
//}
//
//
//protocol AnalyticSerViceDelgate {
//  var listofEvent:[Event] { get }
//  func trackEvent(event:Event)
//  func sendAllEvents(event:[Event])
//  func callAnaltyicsSerivde()
//}
//
//class AnlayticsManger: AnalyticSerViceDelgate{
//    
//
//   static var shared = AnlayticsManger()
//
//    private init() {}
//
//    var listofEvent = [Event]()
//
//    func trackEvent(event: Event) {
//        // Store In DB
//    }
//
//    func sendAllEvents(event: [Event]) {
//
//    }
//
//    func callAnaltyicsSerivde() {
//
//    }
//}
//
//class APiService {
//
//}
//
//class Reachibility {
//    var isIntenetAvailable:Bool = false
//}
//
//
//// Core Data or NSUSerDefault
//class DBHelper {
//
//   // func saveEvents(sa)
//}
//
////+++++++++++++++++++++++++++
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//
//        var payLaod = ["name": "singView", "id": "102"]
//        var event =  Event(name: .viewLoaded, parameter: payLaod)
//
//        AnlayticsManger.shared.trackEvent(event: event)
//    }
//}


//do {
//    var imgData = try Data(contentsOf: URL(string: "")!)
//    var img = UIImage(data: imgData)
//}catch(let error) {
//print("\(error)")
//}
//
//var cache = NSCache<AnyObject, UIImage>()
//
//if let cahceImahe = cache.object(forKey: "" as AnyObject) {
//
//}




//func getMinimalCost(size: [Int], cost: [Int]) -> Int {
//    let n = size.count
//    var sizeCostPairs = zip(size, cost).sorted { $0.0 < $1.0 } // Sort by size
//    var minCost = 0
//    var usedSizes = Set<Int>() // Track used sizes
//    var heap = [(Int, Int)]() // Min-Heap (cost, size)
//
//    for (curSize, curCost) in sizeCostPairs {
//        var newSize = curSize
//        var totalCost = 0
//
//        // Ensure size is unique
//        while usedSizes.contains(newSize) {
//            newSize += 1
//            totalCost += curCost
//        }
//
//        // Update cost and track used sizes
//        usedSizes.insert(newSize)
//        minCost += totalCost
//    }
//
//    return minCost
//}
//getMinimalCost(size: [3,7,9,7,8], cost: [5,2,5,7,5])






//Given a string s, find the length of the longest substring without duplicate characters.
//
//Example 1:
//Input: s = "abcabcbb"
//Output: 3
//
//Example 2:
//Input: s = "bbbbb"
//Output: 1
//
//Example 3:
//Input: s = "pwwkew"
//Output: 3
//
//func longestSubstring(_ str: String) -> Int {
//    var charArr = Array(str)
//    var subString = [String]()
//    var len = 0
//
//    for i in 0..<str.count {
//        var res = ""
//        var innerLen = 0
//
//        for j in i..<str.count {
//            if !res.contains(charArr[j]) {
//                res = res + String(charArr[j])
//                innerLen = innerLen + 1
//            } else {
//                subString.append(res)
//                len = max(len, innerLen )
//                break
//            }
//        }
//    }
//
//    print(subString)
//    print(len)
//
//    return len
//}
//
//longestSubstring("abcabcbb")


//Given an array of strings strs, group the anagrams together. You can return the answer in any order.
//
//Example:
//Input: strs = ["eat","tea","tan","ate","nat","bat"]
//Output: [["bat"],["nat","tan"],["ate","eat","tea"]]


// MARK: - Phone Pe

//1> length of consecutive 1's by repalcing k = 2 zeor's
//Explanation: [1,1,1,0,0,1,1,1,1,1,1]
//Example 2:
//
//Input: nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k = 3
//Output: 10
//Explanation: [0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
//

//2> Histogram
//func lenOfConsone(_ nums: [Int], k: Int) -> Int {
//    var l = 0
//    var r = 0
//    var maxLen = 0
//    var noOfZeros = 0
//
//    while(r<nums.count) {
//        if nums[r] == 0 {
//            noOfZeros += 1
//        }
//
//        while noOfZeros > k {
//            if nums[l] == 0 {
//                noOfZeros -= 1
//            }
//            l += 1
//        }
//        
//        maxLen = max(maxLen, r-l+1)
//        r += 1
//    }
//
//    print(maxLen)
//    return maxLen
//}
//
//lenOfConsone([1,1,1,0,0,0,1,1,1,1,1,1], k: 2)


//2 Histogram max area rectangle

//func largestRectangleArea(_ heights: [Int]) -> Int {
//
//    var nse = findNSE(heights)
//    var pse = findPSE(heights)
//
//    var maxArea = 0
//
//    for i in 0..<heights.count {
//        let area = heights[i] * (nse[i]-pse[i]-1)
//        maxArea = max(maxArea, area)
//    }
//
//    return maxArea
//}
//
//func findNSE(_ nums: [Int]) -> [Int] {
//    var result = Array(repeating: -1, count: nums.count)
//    var stack: [Int] = [] // Stack to store indices
//
//    for i in stride(from: nums.count-1, through: 0, by: -1) {
//        while !stack.isEmpty, nums[i] <= stack.last! {
//               stack.removeLast()
//           }
//
//           if stack.isEmpty {
//               result[i] = -1
//           }else {
//               result[i] = stack.last!
//           }
//         stack.append(nums[i])
//       }
//
//       return result
//}
//
//
//func findPSE(_ nums: [Int]) -> [Int] {
//    var result = Array(repeating: -1, count: nums.count)
//    var stack: [Int] = [] // Stack to store indices
//
//    for i in 0..<nums.count {
//        while !stack.isEmpty, nums[i] <= stack.last! {
//               stack.removeLast()
//           }
//
//           if stack.isEmpty {
//               result[i] = -1
//           }else {
//               result[i] = stack.last!
//           }
//         stack.append(nums[i])
//       }
//
//       return result ci
//}
//
//largestRectangleArea([2,1,5,6,2,3])


//MARK: - Adobe

//1> struct vs class

//2 How to solve a problem to read and write a shared varible by using thread.

//2> Graph -> BFS and DFS Search when to use and its algo.

//3> [1,1,1,0,0,0,2,2,0,1]  sort this array : Use Dutch National Flag Algo

//4> There belwo pixels are given if we select any place, then all pixels related to that should get same color.

//FFFFFFFFFFFFF
//FFFFFFFFFFFFF
//TTTTTTTTTTTTT
//TTTTTTTTFFFFF
//WWWWWWWWWWWWW
//WWWWWWWWWTTTT


// MARK: - Swiggy

//1 Stock App:

//https://docs.google.com/document/d/1V6z6e1f3VVR2b6ye8HzKp4FUF9g4Kb_7K2oe42FbQ8w/edit?userstoinvite=mayank.jha1@swiggy.in&sharingaction=manageaccess&role=writer&tab=t.0
// Receipe App, where user can enter recepie thier ingredients and display that in a list. Now perform search based on ingredeints.

//2> why we used force wrapp in @IBoulet weak var label: UILabel!
//The outlet starts as nil before the view is loaded (because Interface Builder hasn’t connected it yet).
//
//But once the view loads from the storyboard/xib, the outlet is expected to be non-nil for the rest of its lifetime.
//
//So you don’t want to write label?.text all over the code.
//
//Using UILabel! lets you avoid explicit unwrapping or optional chaining everywhere.

//@IBOutlet weak var label: UILabel!    Nil before view loads; assumed non-nil after; convenient access
//@IBOutlet weak var label: UILabel?    Nil before view loads; could be nil later; safer but requires unwrapping

//✅ Why Use UILabel! (Force-Unwrapped Optional) in @IBOutlet?
//IBOutlets are connected at runtime (from Storyboard or XIB):
//When the view controller is loaded from the storyboard, all @IBOutlets are automatically set by the system after the object is initialized and before viewDidLoad() is called.

//Why not make it non-optional (UILabel) then?
//You can’t because Swift requires that all non-optional properties must be initialized during init, and Storyboard injection happens after init — so this would cause a compiler error.

//Why not use a safe optional (UILabel?) then?
//You could, but then you would have to unwrap it every time you use the label:
//label?.text = "Hello"
//That’s verbose and unnecessary since you're almost always certain that the outlet will be connected if the view is set up correctly in the storyboard.
//So we use UILabel!:
//
//It tells the compiler: “Yes, this is optional technically, but trust me — it will be set before I use it.”
//
//So you get the convenience of using it like a non-optional:
//label.text = "Hello"

//❗ What happens if the outlet isn't connected?
//You’ll get a crash at runtime like:
//Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value
//So always double-check your storyboard connections.
//
//✅ Why weak?
//Because UIKit (e.g., UIViewController) already strongly retains its subviews.
//
//To avoid retain cycles and memory leaks, we mark @IBOutlet references as weak — unless there's a specific reason not to.



// MARK: -  Google:

//Implement swipe guesture Algo. Given a string and array of possible strings

// input = "rasjlju"
// possible strings ["run", "rrun", "asu"]
// what is possible output?


// MARK: -  NAVI

// 1> Why arrays and dictionary uses copy on write?
//Swift’s Array, Dictionary, and Set are value types (structs), but they use an internal reference to a heap buffer for storing data
//Copy on Write : is used to avoid the problem of access memory burden.
//Avoid expensive memory copies when passing or assigning large collections.
//Only create a copy when one of them mutates, not just when it's assigned.

//2>When we have large data set need to be copied. Which data structure will be used in swift?
//Collections (Array)  will be  prefered due to COW.


// 3> How to achieve copy on write in struct?
//class Storage {
//    var value: [Int]
//    init(_ value: [Int]) {
//        self.value = value
//    }
//
//    func copy() -> Storage {
//        return Storage(self.value)
//    }
//}
//
//struct COWArray {
//    private var storage: Storage
//
//    init(_ value: [Int]) {
//        self.storage = Storage(value)
//    }
//
//    var value: [Int] {
//        get { storage.value }
//        set {
//            if !isKnownUniquelyReferenced(&storage) {  //isKnownUniquelyReferenced checks if the heap object has exactly one strong reference.After var b = a, both a and b structs reference the same buffer → refcount = 2.
//                storage = storage.copy()
//            }
//            storage.value = newValue
//        }
//    }
//}


// 4> Do Enum have stored property : Ans no, it has computed property
// 5> Disadvantage of sempahores.
//      1. ❗️Deadlocks :If semaphores are not carefully balanced (wait vs signal), you can easily introduce deadlocks.
//      2. ❗️Thread Blocking
//      3. ❗️Priority Inversionn : A low-priority thread holding a semaphore can block high-priority threads waiting for it — leading to priority inversion.

// 7> Can we use unowned in @IBoutlet weak var label : UILabel!
// 8> Deep insight b/w using weak and unowned
//UIKit manages the lifetime of views (like UILabels). Sometimes these views can be unloaded (e.g., low-memory conditions, view controller lifecycle).
//
//weak references automatically become nil when the view is deallocated, so your outlet is safe to check before use.
//
//unowned references do not become nil automatically. If the view is deallocated and you access the outlet, your app will crash.
//
//Because of this, weak is the correct and safe choice for @IBOutlets.




//var a = structA()
//var b = a
//var a = [1,2,3]
//var b = a

//
//enum Color {
//
//    var color = "red"
//
//}


//@IBOutlet unowned var sda:UILabell!

//var b = controllerB()


//struct A {
//    private var a: Int
//}
//
//extension A {
//
//    init(b: Int) {
//        self.init(a: b)
//    }
//}
//
//A(b: 6)


//var value = 5
//
//func testDefer() -> Int {
//    defer { value += 1 }
//
//    return value
//}
//
//print(testDefer())
//print(value)



// MARK: -  Tesco (Machine Round) R1

//1> Print repeated element only max times
//Input: [2,3,3,3,4,4,5,5,5,6,7,7,7,8,8]
//Output: [2,3,3,4,4,5,5,6,7,7,8,8]

//func removeDuplicates(_ arr: [Int], max: Int) -> [Int] {
//
//    var tempArr: [Int:Int] =  [:]
//    var tempArrVisited: [Int:Bool] = [:]
//
//    for i in arr {
//        tempArr[i] = (tempArr[i] ?? 0) + 1
//        tempArrVisited[i] = false
//    }
//
//    var result = [Int]()
//
//    for i in arr {
//        if let counts = tempArr[i], tempArrVisited[i] == false {
//            tempArrVisited
//           tempArrVisited[i] = true
//           var count = counts > max ? max : counts
//            while (count != 0) {
//                result.append(i)
//                count -= 1
//            }
//        }
//    }
//    print(result)
//    return result
//}
//
//removeDuplicates([2,3,3,3,4,4,5,5,5,6,7,7,7,8,8], max: 2)


// Difference between temp and temp2 and delegate pattern
//protocol college: AnyObject {
//    var temp:Int { get }
//    var temp2: Int { get set }
//    func getStudent()
//}
//
//class A: college {
//    var b = B()
//    var temp: Int =  1
//    var temp2: Int = 2
//
//    init() {
//        b.delegate = self
//    }
//
//    func callSendStudnet() {
//        b.sendStudent()
//    }
//
//    func getStudent() {
//        print("studnets")
//    }
//
//}
//
//class B {
//   weak var delegate: college?
//
//    func sendStudent() {
//        delegate?.getStudent()
//    }
//}
//
//var aobj =  A()
//
//aobj.temp = 2
//aobj.callSendStudnet()


// Implement custom map function
//extension Array {
//
//    func customMap<T>(_ transform: (Element) -> T ) -> [T] {
//        var result = [T]()
//
//        for i in self  {
//
//            var value = transform(i)
//            result.append(value)
//        }
//
//        return result
//    }
//}
//
//
//var result = [1,2,3].customMap { $0*2 }
//
//print(result)



//difference when we are using it as a strored property not a computed property with name and age proeprty
//protocol Person {
//    var name: String { get set }
//    var age: Int { get }
//}
//
//struct Student: Person {
//    var name: String         // stored property (read-write)
//    let age: Int             // stored property (minimum read-only)
//}


// MARK: -  Tes0 System Design (R2)
//1> Design Searching functionlity of product and adding the items in Cart:
//2> How to make you SeachViewController Scalable, so that it can used any ViewModel.

// HLL
//Search
//1> List of [Items]
//2> Item- DataModel
//    -->itemID
//    --> name
//    --> image URL
//    --> Quantitiy
//    --> offerID
//    --> price
//    --> Diccount price

//API POST:  /serach/seachtText
//Respomnse: List of [Items]
//
//
//
//VewModel:
// Updating Quantity
// priceCalulation
//
//itemArrya = []
//
//
//View: Checkout/AddToCart:
//
//API POST: api/addToCart/cartID
//
////cartID
//
//Reqesut: item
//   -> ItemId
//   -> price
//   ->Qanutity
//
//Resposne:
//  ->success
//     --> Naivagting CartPage.
//  //->partial Success(successItems, failedItems)
//  ->Failure:
//
//
//// LLD:
//
//MVVM:
//
//
//// SeachView
//
//import UIKit
//
//class SearhViewController: UIViewController, SearchDelegate  {
//
//
//    //override ViewDidload()
//
//    var searchBAr: UISearchController
//    var collectionView: UICollectionView
//
//    var searhcVM:
//
//    init(searhcVM: ) {
//
//    }
//
//
//    func seachText(text: String) {
//        searhcVM.callSeachService()
//
//    }
//
//    func didFinishCall() {
//
//    }
//
//}
//
//
//
//protocol SearchDelegate: AnyObject {
//     func didFinishCall()
//}
//
//class SearchViewModel {
//
//     weak var delegate: SearchDelegate?
//
//    init(service: SeachService)
//
//
//
//    func callSeachService() {
//        delegate?.didFinishCall()
//
//    }
//
//}
//
//protocol SeachServiceDelegate: AnyObject {
//
//}
//
//class SeachService {
//
//}
//
//
//enum GenericViewModelEnum {
//    cases:
//    SearchViewModel
//    case:
//    MoviewViewModel
//}
//
//protocol GenericViewModel {
//
//}
//
//class  FactoryVM {
//
//    func callGenericVM(type: GenericViewModelEnum) -> GenericViewModel {
//        switch type {
//        case SearchViewModel:
//             return SearchViewModel()
//
//        case
//        }
//
//    }
//}
//


//MARK: - MMT

//Problem: 1 Slote wise linklist reversal
//Exp:1 Input: 1->2->3->4->5->6->7->8->9->10 slot = 3
//O/P: 3->2->1->6->5->4->9->8->7->10
//
//Exp:2 Input: 1->2->3->4->5->6->7->8->9->10->11 slot = 3
//O/P: 3->2->1->6->5->4->9->8->7->11->10
//
//Exp:3 Input: 1->2->3->4->5->6->7->8->9->10->11->12->13 slot = 4
//O/P: 4->3->2->1->8->7->6->5->12->11->10->9->13


//class Node {
//    var data:Int
//    var next:Node?
//
//    init(data: Int, next: Node? = nil) {
//        self.data = data
//        self.next = next
//    }
//}
//
//
//var node10 = Node(data: 10)
//var node9 = Node(data: 9, next: node10)
//var node8 = Node(data: 8, next: node9)
//var node7 = Node(data: 7, next: node8)
//var node6 = Node(data: 6, next: node7)
//var node5 = Node(data: 5, next: node6)
//var node4 = Node(data: 4, next: node5)
//var node3 = Node(data: 3, next: node4)
//var node2 = Node(data: 2, next: node3)
//var node1 = Node(data: 1, next: node2)
//
//
//func printLL(_ head: Node?) {
//    guard let head else {
//        return
//    }
//
//    var node: Node? = head
//
//    while(node != nil) {
//        print(node?.data ?? 0)
//        node = node?.next!
//    }
//}

//printLL(node1)


//func revrseLL(_ head: Node?, slot: Int) -> Node? {
//    guard let head else { return nil}
//
//    var startNode: Node?
//    var firstNode = head
//
//    var index = 0
//    var slotSize = slot
//
//    while(slot > 0 ) {
//
//       // guard let head else { return nil}
//
//        var currentNode:Node? = firstNode
//        var prevNode:Node?
//
//        while((index) % slotSize == 0) {
//            index += 1
//            let nextNode = currentNode?.next
//            currentNode?.next = prevNode
//            prevNode = currentNode
//            currentNode = nextNode
//        }
//
//        if index == 2 {
//            startNode = prevNode
//        }
//
//        firstNode = currentNode!
//    }
//
//    return startNode
//}
//
//
//let rev = revrseLL(node1, slot: 3)
//print(rev)
//
////func reverse(_ head: Node?,) -> Node? {
////    guard let head else { return nil}
////
////    var currentNode:Node? = head
////    var prevNode:Node?
////
////    while(currentNode != nil) {
////        let nextNode = currentNode?.next
////        currentNode?.next = prevNode
////        prevNode = currentNode
////        currentNode = nextNode
////    }
////    return prevNode
////}
//
//
//
//    Zizag Traversal of a Tree
//
//class Node{
//    var data: Int
//    var child: [Node]?
//
//    init(data: Int, child: [Node]? = nil) {
//        self.data = data
//        self.child = child
//    }
//}
//
//
//class Tree {
//
//    var
//
//    var rootNode: Node?
//
//    func
//}


//Printing Alternate

//let numberSemaphore = DispatchSemaphore(value: 1)
//let alphabetSempahore = DispatchSemaphore(value: 0)
//
//func printNumbers() {
//    for i in 1...26 {
//        numberSemaphore.wait()
//        print(i, terminator: ", ")
//        alphabetSempahore.signal()
//    }
//}
//
//func printAlphabet() {
//    for i in 0...25 {
//        alphabetSempahore.wait()
//        let lettrer = Character(UnicodeScalar(65+i)!)
//        print(lettrer, terminator: ", ")
//        numberSemaphore.signal()
//    }
//}
//
//DispatchQueue.global().async {
//    printNumbers()
//}
//
//DispatchQueue.global().async {
//    printAlphabet()
//}
//
//sleep(2)




//class Button {
//    func onTapActionButton(_ tapHandler: @escaping () -> ()) {
//        tapHandler()
//    }
//}
//
//class View {
//    var counter = 0
//    Button().onTapActionButton {
//        counter = counter + 1
//        print(counter)
//    }
//
//    Button().onTapActionButton
//}


//
//enum FuelType  {
//    case Petrol
//}
//enum WheelType {
//    case axial
//}
//struct Fuel {
//    var type: FuelType
//}
//struct Wheel {
//    var type: WheelType
//}
//struct Car: Fuel, Wheel {
//    func addFuel() {
//        type = .Petrol
//    }
//    func addWheels() {
//        type = .axial
//    }
//}



//MARK: - Paypal
//var interval1 = [[1,3],[2,6],[8,9],[9,11],[8,10],[2,4],[15,18], [16,17]]
//let interval2 = [[5,10],[15,20],[30,40]]
////
//func countNonConflictingRooms(_ intervals: [[Int]]) -> Int {
//    var count = 0
//    for i in 0..<intervals.count {
//        var hasConflict = false
//        for j in 0..<intervals.count {
//            if i == j { continue }
//            // Check for overlap
//            if intervals[i][0] < intervals[j][1] && intervals[j][0] < intervals[i][1] {
//                hasConflict = true
//                break
//            }
//        }
//        if !hasConflict {
//            count += 1
//        }
//    }
//    return count
//}
//
//let result = countNonConflictingRooms(interval1)
//print(result) // Output: 3
//
//func countNonConflictingRoomsAlgo2(_ intervals: [[Int]]) -> [[Int]] {
//    guard !intervals.isEmpty else { return [] }
//    let sortedInterval = intervals.sorted { $0[0] < $1[0] }
//    var result = [[Int]]()
//    for i in 0..<sortedInterval.count {
//        if result.isEmpty || sortedInterval[i][0] > (result.last?[1])! {
//            result.append(sortedInterval[i])
//        } else {
//            var last = result.last!
//            var lastIndex = result.lastIndex(of: last)
//
//            result[lastIndex!][1] = max((last[1]), sortedInterval[i][1])
//        }
//    }
//    return result
//}
//
//let result2 = countNonConflictingRoomsAlgo2(interval1)
//print(result2) // Output: 3


// MARK: - Target

//Question:1>
//print("1")
//
//DispatchQueue.main.async {
//    print("2")
//
//    DispatchQueue.main.sync {
//        print("3")
//    }
//
//    print("4")
//}
//
//print("5")
//
//Answer: 1 5 2 then deadlock bcz first block is async thats why it will not block the current exection and 5 gets printed
//


//Question:2>
//print("1")
//
//DispatchQueue.main.async {
//    print("2")
//
//    DispatchQueue.global().sync {
//        sleep(2)
//        print("3") // runs on background thread
//    }
//
//    print("4")
//}
//
//print("5")
//
//
//Answer: 1 5 2 3 4 (Note: 4 always comes after 3 as sync will block the main thread)
//

//Question:3>Explain How memory management works here:
//class A {
//    var executor: () -> Void = {}
//
//    func printName(_ name: String) {
//        print(name)
//    }
//
//    deinit {
//        print("A deinit")
//    }
//}
//
//func closureTest() {
//    let a = A()
//
//    var printClosure: (String) -> Void = { [a] str in
//        a.printName(str)
//    }
//
//    var executor: () -> Void = {
//        printClosure("Hello")
//    }
//
//
//    a.executor = executor
//
//}
//
//closureTest()

//ANswer:    -->Retain cycle: "a → executor → printClosure → a"
//           -->And also there will be no output. I
//           -->if you will add this line a.executor() , then it will print hello
//           --> [a] and without capture list : So both forms strongly capture a by default, but using a capture list gives explicit control and clarity — and is necessary for [weak], [unowned], etc.

//
//Question:4>Explain Remove race condition:
//class Counter {
//    var count = 0
//
//    func increment() {
//
//        DispatchQueue.global().async { [weak self] in
//            self?.count += 1
//        }
//    }
//}
//
//let counter = Counter()
//for _ in 0...10 {
//    counter.increment()
//}
//print(counter.count)

//Solution:
//class Counter {
//   fileprivate var count = 0
//
//    var semaphpore = DispatchSemaphore(value: 1)
//
//    func increment(_ group: DispatchGroup) {
//        group.enter()
//        DispatchQueue.global().async { [weak self] in
//            self?.semaphpore.wait()
//            self?.count += 1
//            self?.semaphpore.signal()
//            group.leave()
//        }
//    }
//}
//
//let counter = Counter()
//var group = DispatchGroup()
//
//for _ in 0...10 {
//    counter.increment(group)
//}
//
//group.notify(queue: .main) {
//    print(counter.count)
//}



//class A {
//private var a: String
//
//}
//
//extennsion A {
//func test() {
//print(a)
//}
//}
//
//class B {
//fileprivate var a: String
//
//}
//
//extennsion B {
//func test() {
//print(a)
//}
//}
//
//
//extension Array {
//
//    func customReduce<T>(_ initialResult: T, _ nextPartialResult: (T,Element)->T) -> T {
//
//        var result = initialResult
//
//        for element in self {
//            result = nextPartialResult(result, element)
//        }
//
//        return result
//
//    }
//}
//
//
//[1,2,3,4].customReduce(0) { $0 + $1 }
//view.frame.
//
//enum APIResponse: Codable {
//    case success(data: String)
//    case error(code: Int, message: String)
//}

//{
//    "success": {
//        "data": ""
//    }
//}
//
//{
//    "error": {
//        "code": 0,
//        "message": ""
//    }
//}
//
//
//
//

// 1st Way

//struct APIResponse: Codable {
//    let success: SuccessResponse?
//    let error: ErrorResponse?
//}
//
//struct SuccessResponse: Codable {
//    let data: String
//}
//
//struct ErrorResponse: Codable {
//    let code: Int
//    let message: String
//}
//
//let response = try JSONDecoder().decode(APIResponse.self, from: data)
//
//if let success = response.success {
//    print("✅ Data:", success.data)
//} else if let error = response.error {
//    print("❌ Error:", error.message)
//}

// 2nd Way
//
//enum APIResult {
//    case success(SuccessResponse)
//    case failure(ErrorResponse)
//}
//
//struct APIResponse: Decodable {
//    let result: APIResult
//
//    private enum CodingKeys: String, CodingKey {
//        case success, error
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        if let success = try? container.decode(SuccessResponse.self, forKey: .success) {
//            self.result = .success(success)
//        } else if let error = try? container.decode(ErrorResponse.self, forKey: .error) {
//            self.result = .failure(error)
//        } else {
//            throw DecodingError.dataCorrupted(.init(
//                codingPath: decoder.codingPath,
//                debugDescription: "Neither success nor error found"
//            ))
//        }
//    }
//}
////
//struct SuccessResponse: Decodable {
//    let data: String
//}
//
//struct ErrorResponse: Decodable {
//    let code: Int
//    let message: String
//}

//let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//
//switch apiResponse.result {
//case .success(let s):
//    print("✅ Success data:", s.data)
//case .failure(let e):
//    print("❌ Error:", e.message)
//}




//view.transform = CGAffineTransform(scaleX: 2, y: 2)
//That line makes the view appear twice as big in both directions, without actually modifying its frame values.

// What are responders?

// How to  optionals works under the hood:
//enum MyOptional<T> {
//    case some(T)
//    case none
//
//    // Unwrap the value safely
//    func unwrap() -> T? {
//        switch self {
//        case .some(let value):
//            return value
//        case .none:
//            return nil
//        }
//    }
//
//    // Provide a default value when nil
//    func value(or defaultValue: T) -> T {
//        switch self {
//        case .some(let value):
//            return value
//        case .none:
//            return defaultValue
//        }
//    }
//}
//
//var a: MyOptional<Int>
//a = .some(7)
//
//print(a.value(or: 4))





// MARK: Nykaa R1
//https://chatgpt.com/c/68a2f7b5-48b4-8323-92a3-3c3dde4dc62b

//1>
//class Singleton {
//
//    static let sharedObj = Singleton()
//
//    private init() {}
//
//    func getName() {
//
//    }
//
//}
//
//Singleton.sharedObj.getName()


//2> Factory
//enum ProfileView {
//    case driver
//    case vendor
//}


//class AXy {
//
//    var t: Int = 5
//    var x: (() -> Void)?
//
//    init() {
//        t = 10
//        x = {
//            self.t = 20
//        }
//    }
//}
//
//var a: AXy! = AXy()
//unowned var b: AXy = a
//
//print(a.t) // 10
//a = nil
//print(b.t) // Here we will have crash



//the closure captures self strongly, so:
//
//The AXy instance owns the closure (x).
//
//The closure owns self strongly.
//
//→ Strong retain cycle is created.
//
//So even when you do
//
//a = nil
//
//
//the object is not deallocated, because the closure is holding it alive.
//That’s why b.t is still valid and won’t crash.

/////////////////////
///
///
//protocol ProtocolOne {
//}
//
//extension ProtocolOne {
//    func functionExtension() {
//        print("Extension function")
//    }
//    func functionExtension1() {
//        print("Extension function 1")
//    }
//
//}
//
//extension ProtocolOne where Self: ProtocolTwo {
//    func functionExtension() {
//        print("Apple")
//    }
//}
//
//
//
//protocol ProtocolTwo {}
//
//extension ProtocolTwo {
//    func functionExtension1() {
//        print("Extension function 2")
//    }
//}
//
//
//
//
//class ProtocolRunClass: ProtocolOne,ProtocolTwo {
//    func functionExtension() {
//        print("class function")
//    }
//}
//
//
//typealias ProtocolThree = ProtocolOne & ProtocolTwo
//let instanceOne: ProtocolThree = ProtocolRunClass()
//let instanceTwo: ProtocolOne = instanceOne
//let instanceThree: ProtocolTwo = instanceOne
//
//
//instanceOne.functionExtension() // Apple
//instanceTwo.functionExtension() // Extension function
//instanceThree.functionExtension1() // Extension function 2




//func test() {
//    print("A")
//
//    DispatchQueue.main.async {
//        print("B")
//
//
//        DispatchQueue.main.async {
//            print("C")
//
//
//
//            DispatchQueue.main.async {
//                print("D")
//            }
//        }
//
//        DispatchQueue.global().sync {
//            print("F")
//
//            DispatchQueue.main.async {
//                print("G")
//            }
//        }
//        print("H")
//
//    }
//    print("I")
//}
//
//test()


// A, I, B, H, C, F, D, G


//func dispatchMethod2() {
//    print(1)
//    DispatchQueue.main.async{
//        print(2)
//        DispatchQueue.global().sync{
//            print(3)
//        }
//        print(4)
//    }
//    print(5)
//
//}
//dispatchMethod2() // 1, 5, 2 3 4

//
//func dispatchMethod3() {
//    print(1)
//    DispatchQueue.main.sync{
//        print(2)
//        DispatchQueue.global().sync{
//            print(3)
//        }
//        print(4)
//    }
//    print(5)
//
//}
//
//dispatchMethod3() // 1  .. Deadlock



//private let queue = DispatchQueue(label: "Test")
//
//func run2() {
//    print("Start 1")
//
//    queue.async {
//        print("Start 2222")
//    }
//
//
//    queue.sync {
//        print("Start 3333")
//    }
//
//    print("Start 4444")
//}
//
//run2()

//Start 1, Start 2222, Start 3333, Start 4444


//protocol A: AnyObject {
//    associatedtype T
//    func name(char: T)
//}
//
//
//class B : A {
//
//    weak
//
//    func name(char: String) {
//        <#code#>
//    }
//    
//    typealias T = String
//
//
//}
//
//class C : A {
//    func name(char: Int) {
//
//    }
//    
//    typealias T = Int
//}



//enum Customoption {
//    case some()
//    case none
//}

//extension Array {
//
//    func customReduce<T>(_ initialResult:T, _ nextPartialResult: ((T, Element) -> T)) -> T {
//        var result = initialResult
//
//        for element in self {
//            result = nextPartialResult(result, element)
//        }
//
//        return result
//    }
//}


   // [].reduce


// ViewController
   //UI
    // VM

//protocol
// ViewModel

   // init(: LoginSerViceprotocol)


// LoginSerViceprotocol
// LoginSerVice



// HttPUtiliityService

//func apicall () {
//    URSession
//}

// Validation





// MARK: R:2 Nykaa

//1> Print Sprial Matrix 3,5,6,8,1,1,6,3,7,5,2,
//var arr = [
//    [3,5,6,8],
//    [5,2,4,1],
//    [7,3,6,1]
//]
//
//var arr = [
//    [3,5,6,8],
//    [5,2,4,1],
//    [7,3,6,1],
//    [8,5,3,9]
//]
//
//for i in 0..<arr.count {
//    let lastIndexOFRow = arr[i].count-1
//  //  print(";;\(lastIndexOFRow)")
//    for j in 0..<arr[i].count {
//        if i == 0 {
//            print(arr[i][j], terminator: " ")
//        } else if i > 0 && i < arr.count-1 {
//            print(arr[i][lastIndexOFRow], terminator: " ")
//            break
//        } else if i == arr.count - 1 {
//            var tempj = lastIndexOFRow - j
//                print(arr[i][tempj], terminator: " ")
//        }
//    }
//}
//
//for i in 0..<arr.count {
//    for j in 0..<arr[i].count-1 {
//        if i > 0 && i != arr.count - 1 {
//            print(arr[i][j], terminator: " ")
//        }
//    }
//}


//2> Detect  Cycle in LL

//public class Node {
//     public var val: Int
//     public var next: Node?
//     public init(_ val: Int) {
//         self.val = val
//         self.next = nil
//     }
//  }
//
//
//
//
//func hasLoop(_ head: Node?) -> Bool {
//    guard let head else { return false }
//    var slow: Node? = head
//    var fast: Node? = head
//
//    while fast != nil && fast?.next != nil {
//        slow = slow?.next  // 2 --> 0 --> -4
//        fast = fast?.next?.next // 0 --> 2 --> -4
//
//        if slow === fast {
//            return true
//        }
//    }
//
//    return false
//}


// 3> Rat Maze

//var mat = [
//    [0,-1,-1,-1],
//    [0,0,-1,0],
//    [-1,0,-1,-1],
//    [-1,0,0,0]
//]


//for i in 0..<arr.count {
//    for j in 0..<arr[i].count {
//         // check Right
//         if
//
//
//    }
//}

//var  i = 0, j = 0
//
//while (i<arr.count) {
//
//    if arr[i][j+1] != -1 {
//        print("L")
//        i += 1
//    }
//
//    if arr[i+1][j] != -1  {
//        print("D")
//        j += 1
//    }
//
//    if arr[i+1][j] != -1  {
//        print("L")
//        j -= 1
//    }
//}



// MARK: Phone Pe


// Examples:
// Input: N=6,


// We need to find the minimum number of platforms needed at the railway station so that no train has to wait.

// Examples:
// Input: N=6,
// arr[] = {9:00, 9:45, 9:55, 11:00, 15:00, 18:00}
// dep[] = {9:20, 12:00, 11:30, 11:50, 19:00, 20:00}

//func noofPlatforms(_ arr: [Int], _ dept:[Int]) ->Int {
//
//    var noOfPlatform = 0
//
//    var result = [(Int,Int)]()
//
//    for i in 0..<arr.count {
//
//        if result.isEmpty  || (result.last!.1 < dept[i]) {
//            result.append((arr[i],dept[i]))  //
//        } else {
//            var lastIndex = result.count - 1
//            result[lastIndex].1 = max(result.last!.1, dept[i])
//            noOfPlatform += 1
//        }
//    }
//
//    print(noOfPlatform)
//    return noOfPlatform
//
//}

//var arr = [900, 945, 955, 1100, 1500, 1100]
//var dep = [1820, 1200, 1130, 1150, 1900, 2000]
//
//noofPlatforms(arr, dep)


//50
//25           100
//
//20            55       105
//
//10
//
///// tracversal(left)
/////
//
//
//func fomtionTree(_ root: Node?, eleemt:inout[Int], index:Int) {
//
//gurad llet node = root {
//// insert
//return
//}
//fomtionTree(node.left)
//omtionTree(node.rright)
//
//
//}

//50,10,25,100,20,55,105



// MARK: - Expedia R1

// 3 Sum Problem
//func threeSum(_ nums: [Int]) -> [[Int]] {
//
//    var result = Set<[Int]>()
//
//    for i in 0..<nums.count {
//        var dict = Set<Int>()
//        for j in i+1..<nums.count {
//            var third = -(nums[i]+nums[j])
//
//            if dict.contains(third) {
//                result.insert([nums[i], nums[j], third].sorted())
//            }
//            dict.insert(nums[j])
//        }
//
//    }
//    return Array(result)
//}

//var ans = threeSum([-1,0,1,2,-1,-4])
//
//print(ans)


// actor-based solution for a simple bank account system where multiple tasks can deposit (credit) and withdraw money safely without race conditions.

//actor BankAccount {
//    var balance:Int
//
//    init(_ amount: Int) {
//        balance = amount
//    }
//
//    func withDrawAmount(_ amount: Int) {
//        balance -= amount
//    }
//
//    func addAmount(_ amount:Int) {
//        balance += amount
//    }
//
//    func getBalance() -> Int {
//        balance
//    }
//}
//
//
//let obj = BankAccount(10000)
//
//for i in 1...10 {
//    Task {
//        await obj.withDrawAmount(500)
//        print("Task \(i): withdrew 500")
//    }
//}
//
//for i in 11...20 {
//    Task {
//        await obj.addAmount(1000)
//        print("Task \(i): deposited 1000")
//    }
//}
//
//Task {
//    try await Task.sleep(nanoseconds: 1_000_000_000) // wait 1 sec
//    print("Final Balance:", await obj.getBalance())
//}



//For above code, can you fix, so that at a time max 3 request can go
//func fetchAll(urls: [URL]) async throws {
//    let (data, error) = try await URLSession.shared.data(from: urls)
//    return data
//}


//func fetchAll(urls: [URL]) async throws -> [Data] {
//    let sem = DispatchSemaphore(value: 3)
//    var results = [Data]()
//    let lock = NSLock()
//
//    try await withThrowingTaskGroup(of: Void.self) { group in
//        for url in urls {
//            group.addTask {
//                sem.wait() // take a slot
//                defer { sem.signal() } // release when done
//
//                let (data, _) = try await URLSession.shared.data(from: url)
//
//                // protect shared array
//                lock.lock()
//                results.append(data)
//                lock.unlock()
//            }
//        }
//        try await group.waitForAll()
//    }
//    return results
//}

//But this is mixing old GCD world (DispatchSemaphore) with Swift concurrency, which isn’t ideal.
//The pure async/await solution with AsyncSemaphore (actor-based) I gave earlier is the “Swifty” way.
//

//MARK: Expedia: R2

//func missingNumber(_ nums: [Int]) -> Int {
//    let arr = nums.sorted()
//    var countDict = [Int:Int]()
//    var prev = arr[0]
//
//    for i in 1..<arr.count {
//        print(arr[i]-prev)
//        countDict[arr[i]-prev, default:0] += 1
//        prev = arr[i]
//
//    }
//    print(countDict)
//
//    var diff = countDict.sorted{$0.value>$1.value}[0].key
//
//    for i in 1..<arr.count {
//        if arr[i-1]+diff != arr[i] {
//            return arr[i-1] + diff
//        }
//    }
//
//    return 0
//
//}
//
//missingNumber([2,6,8,10,12])


// MARK: Nobroker

// Model
//struct UserModel:Decodable {
//    let userName:String?
//}
//
//
////ApiManager
//
//protocol ApiManagerProtocol {
//    func getData<T: Decodable>(url: String, type: T.Type) async throws -> Result<T, Error>
//}
//
//class ApiManager:ApiManagerProtocol {
//    func getData<T: Decodable>(url: String, type: T.Type) async throws -> Result<T, Error> {
//
//      let (data, resposne) = try await URLSession.shared.data(for: URLRequest(url: URL("")!))
//
//    }
//    return .suc
//}
//
//
//// Respository
//
//protocol RespositoryProtocol {
//    func getData() async throws  -> UserModel
//}
//
//class Respository: RespositoryProtocol {
//    func getData() async throws -> UserModel {
//
//    }
//
//}
//
//class ViewModel {
//
//    var repo:RespositoryProtocol = Respository()
//
//    func loadData() {
//
//        let task = Task {
//            do {
//               let userModel = try await repo.getData()
//
//            } catch (let error) {
//                print("erorr")
//            }
//        }
//    }
//
//    func downloadImage() async throws -> Data{
//        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: URL(filePath: "")!))
//
//
//        return data
//    }
//}


//
//How to downloadImage() using Task with cancel feature/
//class UserViewController: UIViewController {
//    private let imageView = UIImageView()
//    func load() {
//
//      let task = Task {
//         let image = await imageView.downloadImage()
//          imageView.image = image
//        }
//
//        task.cancel()
//    }
//}



// MARK: - Folk Interview Question:

//-->Diff bw barrier and Semaphore
//-->structured Concurrency in Swift
//--> optionals custom implementation
//--> Implement custom property @propertyWrapper
//-->Task VS Task Detached VS Task group
//-->how to convert closure based api call to async await in SwiftUI
//--> can we cancel task in GCD
//--> Diff bw GCD. operation Queue
//--> small login screen in Swift UI


//import SwiftUI
//
//class ViewModel: ObservableObject {
//    @Published var email:String = ""
//    @Published var password: String = ""
//}
//
//struct ContentView: View {
//    @ObservedObject var vm = ViewModel()
//    var body: some View {
//        VStack(spacing: 10) {
//            Text("Login Screen")
//            Spacer()
//            VStack {
//                TextField("Enter Email", text: $vm.email)
//                TextField("Password", text: $vm.password)
//                Button("Login") {
//
//                }
//            }
//        }
//    }
//}


// MARK: - JP Morgan
// StateObject VS obersved Object : What you will use in APIManager
// Life Cycyle of App
// What are preference Keys
// what is silent push
// if you want to store username in app, and it persist untill your app wont delted. what you will prefer?
//    1. 🔐 Keychain (Best for secure storage)
//    2. 💾 UserDefaults (For simple data like username, password etc)
// what is MVVM- C pattern


// MARK: - CVent
//Q1>Consume the API https://www.gutenberg.org/files/1342/1342-0.txt using URLSession.
//Take 30,000 characters from the result of one call and 40,000 characters from the result of another call.
//Extract every 10th incremented character(like 10 th,20th 30th etc) until string length from both fetched chunks.
//Use a single resource to store and update both results concurrently.
//Display the final character count and processed string in two separate SwiftUI components.


//1. Your API Manager (kept, with small safety fix)
class APIMAnager {
    func getAPI(_ url: URL) async throws -> String {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let text = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        return text
    }
}

//🔹 2. Your Corrected Slicing Logic ✅
enum OperationType {
    case thirtyK
    case fortyK
}

func sliceData(_ type: OperationType, string: String) -> String {
    let limit = (type == .thirtyK) ? 30000 : 40000
    
    var result = ""
    
    for (index, char) in string.enumerated() {
        if index >= limit { break }
        
        // 10th, 20th, 30th...
        if (index + 1) % 10 == 0 {
            result.append(char)
        }
    }
    
    return result
}


//🔹 3. Single Shared Resource (Thread-safe 🔥)
actor ResultStore {
    private(set) var combinedText: String = ""
    
    func append(_ text: String) {
        combinedText += text
    }
    
    func getFinal() -> String {
        return combinedText
    }
}


//🔹 4. Independent Concurrent Calls (Improved Version 💡)
func getData() async throws -> (String, Int) {
    guard let url = URL(string: "https://www.gutenberg.org/files/1342/1342-0.txt") else {
        return ("", 0)
    }
    
    let manager = APIMAnager()
    let store = ResultStore()
    
    async let task1: Void = {
        let text = try await manager.getAPI(url)
        let processed = sliceData(.thirtyK, string: text)
        await store.append(processed)
    }()
    
    async let task2: Void = {
        let text = try await manager.getAPI(url)
        let processed = sliceData(.fortyK, string: text)
        await store.append(processed)
    }()
    
    _ = try await (task1, task2)
    
    let final = await store.getFinal()
    return (final, final.count)
}


//🔹 5. ViewModel (SwiftUI Binding)
import SwiftUI

@MainActor
class BookViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var count: Int = 0
    
    func load() {
        Task {
            do {
                let (result, count) = try await getData()
                self.text = result
                self.count = count
            } catch {
                print("Error:", error)
            }
        }
    }
}

//🔹 6. SwiftUI View
struct ContentView: View {
    @StateObject private var vm = BookViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Character Count: \(vm.count)")
                .font(.headline)
            
            ScrollView {
                Text(vm.text)
                    .font(.caption)
                    .padding()
            }
        }
        .onAppear {
            vm.load()
        }
    }
}


//Q2>🔹 Problem Summary
//Parent1 → struct (shared model)
//DataModel1 → has Parent1
//DataModel2 → also has Parent1
//ParentDataModel → contains both DataModel1 & DataModel2
//
//👉 Issue:
//
//DataModel2 receives wrong/mismatched key
//You want to know:
//👉 How to identify where decoding failed?

//ParentDataModel → dataModel2 → parent1 → name

//func printDecodingError(_ error: DecodingError) {
//    switch error {
//        
//    case .keyNotFound(let key, let context):
//        let path = context.codingPath.map { $0.stringValue }
//        
//        print("❌ Missing key:", key.stringValue)
//        print("📍 Full Path:", path.joined(separator: " → "))
//        
//        if path.count >= 2 {
//            print("🔥 Issue likely in:", path[path.count - 2]) // parent container
//        }
//        
//    case .typeMismatch(_, let context):
//        let path = context.codingPath.map { $0.stringValue }
//        
//        print("📍 Full Path:", path.joined(separator: " → "))
//        
//        if path.count >= 1 {
//            print("🔥 Issue in model:", path.last ?? "")
//        }
//        
//    default:
//        print(error)
//    }
//}
//🔥 Output Now
//❌ Missing key: name
//📍 Full Path: parentDataModel → dataModel2 → parent1 → name
//🔥 Issue likely in: parent1

//👉 You don’t need custom init in every model
//
//Because:
//
//codingPath already gives full hierarchy
//You just need to interpret or format it properly


//MARK: - eBay:

// AnyPublisher
// Just
// map vs flatMap in combine
// passThorugh Subject vs Current Valye subject
// How you will hanlde threading in combine
// AnyCancellable
// Max Sum Subarryay


//MARK: - Albertsons : R1

//SwiftUI Vs UIKit
// Dispatch Methods
// VIPER
// How options functin in protocol
// Migration in core DatA
// Multithreadinh in coreData
// SwiftData

func test() {

    DispatchQueue.main.async { // 1st block in main

        print("a")

        DispatchQueue.global().sync {

            print("b")

            DispatchQueue.main.async { // 2nd block in main

                print("c")

            }

            print("d")

        }

        print("e")

        DispatchQueue.main.async { //3rd  block in main

            print("f")

        }

    }

}
 
// a, b, d, e, c, f
test()


/*
Coronavirus spreads when one person comes in contact with the affected person. It is known that person X is affected with it initially and he comes in contact with some other persons

SUNIL MOHAN
MOHAN PANKAJ
RAHUL SUNIL
AKSHAY VIVEK
VIVEK AVAY
 
 X = SUNIL, Y= PANKAJ
X = AVAY, Y= SUNIL
Output = [no]

 */

//let dataSet = [
//    ["SUNIL","MOHAN"],
//    ["MOHAN", "PANKAJ"],
//    ["RAHUL", "SUNIL"],
//    ["AKSHAY", "VIVEK"],
//    ["VIVEK", "AVAY"]
//]
//
//
//func isInfected(_ x:String, _ y:String) -> Bool {
//    
////  let filter = dataSet.filter { <#[String]#> in
////        <#code#>
////    }
//    var source = x
//    for row in dataSet {
//        let index = row.firstIndex(of: source)
//                
//        if index == 0 {
//            source = row[1]
//        }else {
//            source = row[0]
//        }
//        
//        if source == y {
//            return true
//        }
//        
//        continue
//        
//    }
//    
//    return false
//}
//
//print(isInfected("AVAY", "SUNIL"))


//MARK: -  iXigo
// Write Swift Code to implement below UI
//https://chatgpt.com/c/6ab10e23-e538-83e8-b5b8-070be2b5a6fc

// (Expedia): How internally Publisher and Subscriber work . can you implement it?

/*
┌───┬───┬───────┐
│ G │ R │       │
├───┼───┤       │
│ R │ G │       │
├───┴───┼───────┤
│       │ G │ R │
│       ├───┼───┤
│       │ R │ G │
└───────┴───┴───┘
 
 */







































