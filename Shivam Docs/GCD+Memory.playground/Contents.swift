import Foundation
import CoreFoundation
import PlaygroundSupport
import XCTest

PlaygroundPage.current.needsIndefiniteExecution = true


//MARK: - GCD

//https://chatgpt.com/c/6898057b-6034-832a-90d7-2c0e73890b61
//
//func test() {
//    print("A") //1 Block in main
//
//    DispatchQueue.main.async { //2 Block in main
//        print("B")
//
//
//        DispatchQueue.main.async { //3 Block in main
//            print("C")
//
//
//
//            DispatchQueue.main.async { //5 Block in main
//                print("D")
//            }
//        }
//
//        DispatchQueue.global().sync { // Block 2nd thread
//            print("F")
//
//            DispatchQueue.main.async { //4 Block in main
//                print("G")
//            }
//        }
//        print("H")
//
//    }
//    print("I")
//}
////
//test()

// A, I, B, F, H, C, G, D

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


//func dispatchMethod3() {
//    print(1)  // 1st Block in Main Queue
//    DispatchQueue.main.sync {  // 2nd Block in Main Queue [ But until 1st block not completed, this block wont execute]
//        print(2)
//        DispatchQueue.global().sync{ // Block in 2nd thread
//            print(3)
//        }
//        print(4)
//    }
//    print(5)
//
//}
//
//dispatchMethod3() // 1  .. Deadlock
// But if we will  change from main Queue, to serial it will not block.


//private let queue = DispatchQueue(label: "Test")
//
//func run2() {
//    print("Start 1") // 1st Block in Main Queue
//
//    queue.async { // 1st Block in Serial Queue
//        sleep(2)
//        print("Start 2222")
//    }
//
//    print("sdv")
//
//    queue.sync {  // 2nd Block in Serial Queue but this blocks our main Queue, bcz its called from main thread
//        print("Start 3333")
//    }
//
//    print("sdsadfv")
//
//    print("Start 4444")
//}
//
//run2()

//Start 1, Start 2222, Start 3333, Start 4444



//Question:1>
//print("1")   // 1st Block in main
//
//DispatchQueue.main.async {  //2nd Block
//    print("2")
//
//    DispatchQueue.main.sync {  // 3rd Block : Deadlokc
//        print("3")
//    }
//
//    print("4")
//}
//
//print("5")

//Answer: 1 5 2 then deadlock bcz first block is async thats why it will not block the current exection and 5 gets printed


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
//Answer: 1 5 2 3 4 (Note: 4 always comes after 3 as sync will block the main thread)


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
//    var semaphpore = DispatchSemaphore(value: 1) //This guarantees only one thread can modify count at a time.
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
//for _ in 0...100000 {
//    counter.increment(group)
//}
//
//group.notify(queue: .main) {
//    print(counter.count)
//}

/*
 Q: Do we need Smeaphore ?
 A:This line is not atomic:
 self?.count += 1

 Internally it does:
 read count
 add 1
 write count
 
 self?.semaphpore.wait()
 self?.count += 1
 self?.semaphpore.signal()

 This guarantees only one thread can modify count at a time.
 
 */





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



// 5> Disadvantage of sempahores.
//      1. ❗️Deadlocks :If semaphores are not carefully balanced (wait vs signal), you can easily introduce deadlocks.
//      2. ❗️Thread Blocking: If signal() is forgotten, threads block forever.
//      3. ❗️Priority Inversionn : A low-priority thread holding a semaphore can block high-priority threads waiting for it — leading to priority inversion.
//      4. Semaphore is heavier: It is designed for resource management, not just locking.



//How to solve a problem to read and write a shared varible by using thread.

//actor Stocks {
//    var phones = ["iphone A", "iphone B", "iphone C"]
//
//    func getAvailablePhones() {
//        let value = phones
//       // sleep(1)
//        print("Available phones are \(value)")
//    }
//
//    func purchasePhones(_ phone: String) {
//        let index = phones.firstIndex(of: phone)!
//        // sleep(3)
//
//        phones.remove(at: index)
//
//
//        print("Congratulations on purchaseing this  \(phone)")
//    }
//}
//
//
//func replicateRaceCondition() {
//    let stockObj = Stocks()
//    var stockQueue = DispatchQueue(label: "conurrent", attributes: .concurrent)
//
//    //Use Task { } instead of DispatchQueue, Think Task as the modern replacement for DispatchQueue.async, but fully aware of Swift’s structured concurrency model.
//   // stockQueue.async {
//        Task {
//            await stockObj.purchasePhones("iphone B")
//        }
//   // }
//    print("Shivam")
//   // stockQueue.async {
//        Task {
//            await  stockObj.getAvailablePhones()
//        }
//   // }
//}


//replicateRaceCondition()




// Problem
//class Counter {
//    var value = 0
//
//    func increment() {
//        let current = value
//       // sleep(1)  // Simulate some processing delay
//        value = current + 1
//    }
//
//    func getValue() -> Int {
//        return value
//    }
//}
//let counter = Counter()
//let queue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
//
//for _ in 1...10 {
//    queue.async {
//        counter.increment()
//    }
//}
//
////sleep(6)
//print("Final counter value: \(counter.getValue())")

//Solution1> Using Seamphore:
//class Counter {
//    private var value = 0
//    private let semaphore = DispatchSemaphore(value: 1)
//
//    func increment() {
//        semaphore.wait()
//        defer { semaphore.signal() }
//
//        value += 1
//    }
//
//    func getValue() -> Int {
//        semaphore.wait()
//        defer { semaphore.signal() }
//
//        return value
//    }
//}
//
//let counter = Counter()
//let group = DispatchGroup()
//
//for _ in 1...5 {
//    group.enter()
//
//    DispatchQueue.global().async {
//        counter.increment()
//        group.leave()
//    }
//}
//
//group.notify(queue: .main) {
//    print("Final counter value: \(counter.getValue())")
//}

// Solutions2: using Acrtors

//actor Counter {
//    var value = 0
//
//    func increment() {
//        let current = value
//        sleep(1)  // Simulate some processing delay
//        value = current + 1
//    }
//
//    func getValue() -> Int {
//        return value
//    }
//}
//let counter = Counter()
//
//for _ in 1...5 {
//    Task {
//        await counter.increment()
//    }
//}
//print("FDASG")
//
//Task {
//    print("wret")
//    let val = await counter.getValue()
//    print("Final counter value: \(val)")
//}




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
//var serial = DispatchQueue(label: "serial", attributes: .concurrent)
//
//serial.sync {
//
//    for i in  1...10 {
//        print("Shivam")
//    }
//
//    serial.sync {
//        for i in  1...10 {
//            print("Gupta")
//        }
//    }
//}
//
//for i in  1...10 {
//    print("Gupta1")
//}
// Play above as much as you can with output by changing async , sync and serial tocurrent





//Q4>
//class MyClass: @unchecked Sendable {
//    static let shared = MyClass()
//    var aDict = [String: Int]()
//    var sempahoreWrite = DispatchSemaphore(value: 1)
//    var sempahoreRead = DispatchSemaphore(value: 0)
//    func readData() {
//        sempahoreRead.wait()
//        print("Reading data")
//        print("\(String(describing: aDict["key"]))")
//        sempahoreWrite.signal()
//    }
//
//    func writeData() {
//        sempahoreWrite.wait()
//        print("Writing data")
//        self.aDict["key"] = 30
//        sempahoreRead.signal()
//    }
//}
//
// //Simulating Race Condition
//let sharedInstance = MyClass.shared
//let concurrentQueue = DispatchQueue(label: "com.example.raceCondition", attributes: .concurrent)
//
//
//concurrentQueue.async {
//    for _ in 0..<10 {
//        sharedInstance.writeData()
//    }
//}
//
//
//concurrentQueue.async {
//    for _ in 0..<10 {
//       sharedInstance.readData()
//    }
//}
//
////// Adding a delay to keep the playground running
//DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    print("Finished")
//}



// MARK: - Memory Management


//1> COW on Notes 2
//2>. Notes 4
//3>.https://chatgpt.com/c/68c4fe44-2170-8330-b901-9a60d0bd363c




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
//var a: AXy! = AXy()  // as below as is set to be nil , for that a must b optional.
//unowned var b: AXy = a
//
//print(a.t) // 10
//a = nil
//b
//a
//print(b.t) // Here we will have crash   : No Crash



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

///AXy instance ─► x closure ─► self (AXy instance again)/  <--- Retain Cycle



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
//    a.executor = executor
//
//}
//
//closureTest()

//ANswer:    -->Retain cycle: "a → executor → printClosure → a"
//           -->And also there will be no output. I
//           -->if you will add this line a.executor() , then it will print hello
//           --> [a] and without capture list : So both forms strongly capture a by default, but using a capture list gives explicit control and clarity — and is necessary for [weak], [unowned], etc.




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
//            if !isKnownUniquelyReferenced(&storage) {  //meaning no other variable holds a reference to it.
//                storage = storage.copy()
//            }
//            storage.value = newValue
//        }
//    }
//}



// 7> Can we use unowned in "@IBoutlet weak var label : UILabel!"
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
//b.append(5)
//
//a.withUnsafeBufferPointer { pointer in
//    print(pointer)
//}
//b.withUnsafeBufferPointer { pointer in
//    print(pointer)
//}
//@IBOutlet unowned var sda:UILabell!



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



//--> Copy in Write for struct : Applicable for value type (struct) in case of array only
// Answer : Only for collections




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
// print(stuObj.temp === stuObj.temp)//Are both references pointing to the exact same object in memory
//[1].withUnsafeBufferPointer { p in
//
//}
//
//withUnsafePointer(to: stuObj.temp) { print("stuObj.temp memory address: \($0)") }
//withUnsafePointer(to: stuObj1.temp) { print("stuObj1.temp memory address: \($0)") }
//
//// Print Refernce Type memory location
//Unmanaged.passUnretained(stuObj.temp).toOpaque()
//Unmanaged.passUnretained(stuObj1.temp).toOpaque()
//
// //1️⃣ Prints address of the reference variable inside the struct
//withUnsafePointer(to: &stuObj.temp) {
//    print("Address of stuObj.temp reference variable: \($0)")
//}
//withUnsafePointer(to: &stuObj1.temp) {
//    print("Address of stuObj1.temp reference variable: \($0)")
//}
//
//// 2️⃣ Prints address of the actual class instance
//print("stuObj.temp instance address:", Unmanaged.passUnretained(stuObj.temp).toOpaque())
//print("stuObj1.temp instance address:", Unmanaged.passUnretained(stuObj1.temp).toOpaque())
//


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


 //Concept of memory in case of computed vs lazy property
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
//
//   let closure = {
//
//       print("a is \(5)")
//
//    }
//}
////
//var a = A()
//a.closure()
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
//     //closure = myClass.createClosure() // Creates a strong reference cycle
//     closure = myClass.createWeakClosure() // No strong reference cycle
//    closure?()
//}
//// If using createClosure(), `deinit` won't be called
//// If using createWeakClosure(), `deinit` will be called
//
//closure?() // Access the closure; behavior depends on capture type


//MARK: - Top Questions:

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
//// force unwrap
//    func forceUnwrap() -> T {
//        switch self {
//        case .some(let value):
//            return value
//        case .none:
//            fatalError("Tried to unwrap nil value")
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
//
//// Unwrapping like if let
//a = .some(7)
//if let val = a.unwrap() {
//    print(val)
//}
//
//// Force Unwrapping
//a = .none
////let v = a.forceUnwrap()
//
//
//print(a.value(or: 4))


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
//}
//
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
//
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


//// 3> How to achieve copy on write in struct?
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
//                //true if object is known to have a single strong reference; otherwise, false.
//                storage = storage.copy()
//            }
//            storage.value = newValue
//        }
//    }
//}
//
//var arr1 = COWArray([1,2,3])
//var arr2 = arr1
//arr1.value.withUnsafeBufferPointer {
//    print($0)
//}
//arr2.value.withUnsafeBufferPointer {
//    print($0)
//}
//
//arr2.value.append(4)
//arr1.value.withUnsafeBufferPointer {
//    print($0)
//}
//arr2.value.withUnsafeBufferPointer {
//    print($0)
//}



// MARK: - Methods Dispatch

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
//
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
//greeter.greet() // Output: "Hello from Person" and dynamic dispatch for protocols via witness table

//V-table = dynamic dispatch for classes (inheritance).
//Witness table = dynamic dispatch for protocols (protocol conformance).
//Both provide runtime polymorphism, but for different language features.

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

/**
 📊 V-Table Diagram (No override)
 class Animal {
     func sound() {
         print("Animal sound")
     }
 }

 class Dog: Animal {
     // no override
 }

 let a: Animal = Dog()
 a.sound() // Animal sound

 Animal V-Table
 ┌────────────────────────┐
 │ sound() → Animal.sound │
 └────────────────────────┘


 Dog V-Table (inherits)
 ┌────────────────────────┐
 │ sound() → Animal.sound │
 └────────────────────────┘


 Heap Object (Dog instance)
 ┌──────────────────────┐
 │ type metadata ───────┼──► Dog V-Table
 └──────────────────────┘


 📊 V-Table Diagram (With override)
 class Animal {
     func sound() {
         print("Animal sound")
     }
 }

 class Dog: Animal {
     override func sound() {
         print("Dog barks")
     }
 }

 let a: Animal = Dog()
 a.sound() // Dog barks

 Animal V-Table
 ┌────────────────────────┐
 │ sound() → Animal.sound │
 └────────────────────────┘


 Dog V-Table
 ┌───────────────────────┐
 │ sound() → Dog.sound   │  ✅ replaced
 └───────────────────────┘


 Heap Object (Dog instance)
 ┌──────────────────────┐
 │ type metadata ───────┼──► Dog V-Table
 └──────────────────────┘

 */


//nonisolated Keyword
//
//actor AudioPlayer {
// var volume: Double = 1.0

// func setVolume(_ v: Double) {
// volume = v
// }
// // nonisolated: callable without await
// nonisolated func appName() -> String {
// return "MusicApp" // no mutable state
// }
//}


//actor Counter {
//    var count = 0
//
//    nonisolated func getCount() -> Int {
//        return count
//    }
//}



//final class User: Sendable {
//    let name: String = ""
//}

//struct User: Sendable {
//    let name: String
//}

import Combine
//let publisher1 = Just(10)
//    .map { $0 * 2 }
//
//print(publisher1)


//class Counter {
//    var values = 0
//}
//func test() {
//    let counter = Counter()
//    
//    Task {
//        counter.values = 10
//    }
//    
//    print(counter.values)
//}
//
//test()
//
//
//[1,2,3].publisher.eraseToAnyPublisher()
//
//
//class ViewModel {
//    @Published var name: String = ""
//}
//
//let publisher = Just("Abhinav")
//
//publisher.assign(to: \.name, on: ViewModel())


//let publisher = Just(10)
//    .map { $0 * 2 }
//    
//print(publisher)
//print(publisher.eraseToAnyPublisher())


// MARK: -  MAP VS FlatMap
//func apiCall(_ value: Int) -> AnyPublisher<String, Never> {
//    Just("Result \(value)").eraseToAnyPublisher()
//}
//
//let publisher11 = Just(5)
//    .map { apiCall($0) }
//    
//print("publisher’s11 concrete type:     \(publisher11)")
//publisher11.sink { value in
//        print(value)
//    }
//
//let publisher12 = Just(5)
//    .flatMap { apiCall($0) }
//    
//print("publisher’s12 concrete type:     \(publisher12)")
//publisher12.sink { value in
//        print(value)
//    }

// MARK: - CombineLatets
let publisher1 = PassthroughSubject<String, Never>()
let publisher2 = PassthroughSubject<Int, Never>()


//publisher1
//    .combineLatest(publisher2)
//    .sink { val1, val2 in
//        print("Combined:", val1, val2)
//    }
//
//print(publisher1)
//publisher1.send("A")   // ❌ no output yet
//publisher2.send(1)     // ✅ ("A", 1)
//
//publisher1.send("B")   // ✅ ("B", 1)
//publisher2.send(2)     // ✅ ("B", 2) 

// MARK: - ZIP
//publisher1
//    .zip(publisher2)
//    .sink { value1, value2 in
//        print("zip:", value1, value2)
//    } 
//
//publisher1.send("A")   // ❌ no output
//publisher2.send(1)     // ✅ ("A", 1)
////
//publisher1.send("B")   // ❌ waits
//publisher2.send(2)     // ✅ ("B", 2)


// MARK: - SwitchToLatest
//let subject = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
//
//subject
//    .switchToLatest()
//    .sink { print($0) }
//let pub1 = [1,2,3,4,5,6].publisher.eraseToAnyPublisher()
//let pub2 = [10,20].publisher.eraseToAnyPublisher()
//
//subject.send(pub1) // starts pub1
//subject.send(pub2) // cancels pub1, starts pub2


//MARK: - Throttle

//class ButtonTapViewModel {
//    private var cancellables = Set<AnyCancellable>()
//    func configureButtonTapHandling() {
//        let buttonTapPublisher = PassthroughSubject<Void, Never>()
//        buttonTapPublisher
//            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
//            .sink { [weak self] _ in
//                self?.handleButtonTap()
//            }
//            .store(in: &cancellables)
//        simulateButtonTapEvents(buttonTapPublisher)
//    }
//    private func handleButtonTap() {
//        // Perform the desired action here
//    }
//    private func simulateButtonTapEvents(_ publisher: PassthroughSubject<Void, Never>) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            publisher.send(())
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//            publisher.send(())
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//            publisher.send(())
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//            publisher.send(())
//        }
//    }
//}
//let viewModel = ButtonTapViewModel()
//viewModel.configureButtonTapHandling()





//let subject = CurrentValueSubject<Int, Never>(5)
//
//subject.sink { val in
//    print(val)
//}
//
//subject.value = 6
//subject.send(7)
//subject.send(completion: .finished)
//subject.send(8)


// MARK: - custom subscriber
class MySubscriber: Subscriber {
    typealias Input = Int
    
    typealias Failure = Never
    
    func receive(subscription: any Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received:", input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
}
//
//let publisher = [1,2,3,4].publisher
//let subscriber = MySubscriber()
//
//publisher.subscribe(subscriber)

//Received: 1
//Received: 2
// MARK: - USerDeafults

//UserDefaults.standard.set("Abhinav", forKey: "username")
//UserDefaults.standard.set(true, forKey: "isLoggedIn")
//UserDefaults.standard.set(25, forKey: "age")
//
//
//let username = UserDefaults.standard.string(forKey: "username")
//let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
//let age = UserDefaults.standard.integer(forKey: "age")
//
//print(username)


//MARK: - Questions
//var x = 10
//
//@MainActor
//func increament() -> ()->Int {
//    var total = x
//    return {
//        total += 1
//        return total
//    }
//}
//
//    let inc1 = increament()
//     x = 20
//
//    let inc2 = increament()
//    
//    print(inc1())
//    print(inc1())
//    print(inc2())




actor DataManager {
    func updateData(_ user: User) {
        
    }
}


class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


class VM: ObservableObject {
    var manger = DataManager()
    
    func sendData(user: User) async {
        await manger.updateData(User(name: ""))
    }
}

var components = URLComponents(string: "https://api.ebay.com/feed")!

        var queryItems: [URLQueryItem] = []

      //  if let cursor {
            queryItems.append(.init(name: "cursor", value: "abd"))
       // }

        components.queryItems = queryItems

print(components.url)


var cache = NSCache<NSString,UIImage>()
cache.setObject(<#T##obj: UIImage##UIImage#>, forKey: <#T##NSString#>)
cache.object(forKey: <#T##NSString#>)


var runningTask = [URL: Task<UIImage?, Never>]()


func test() async {
    await withTaskGroup(of: String.self) { group in
        group.addTask {
            return "A"
        }
        
        group.addTask {
        
            return "C"
        }
    }
}



func sortArrayByParityII(_ nums: [Int]) -> [Int] {
    var left = 0
    var right = nums.count-1
    
    while left < right {
        if left
    }
    
    return nums
}
