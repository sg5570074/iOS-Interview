import Foundation
import Combine
import PlaygroundSupport
/*:
 # Fundamentals Questions
 
 ## Instructions
 Each test section starts with relevant material for the test followed by the instructions and the relevant test function. At the begining of each test function you will see a `return` statement. Remove the statement to enable the code in that section.
 
 Good luck!
 */
/*:
 ---
 ## Protocols
 */
protocol MyProtocol {
	associatedtype MyType
	var value: MyType { get }
	var isInteger: Bool { get }
}

extension MyProtocol {
	var isInteger: Bool {
		false
	}
}

struct ConformingClass: MyProtocol {
	let value: Int
}

/*:In the space below write an extension to MyProtocol such that if the type of MyType is an Int, the variable isInteger returns true.*/

extension MyProtocol where MyType == Int {
    var isInteger: Bool {
        true
    }
    
}

// Write extension here

func doProtocolsTest() {
	//return
	let myClass = ConformingClass(value: 12)
	print("Result is integer: \(myClass.isInteger)")
}



/*:
 ---
 ## Memory
 */
class MemoryService {
	private var callBack: ((Int) -> Void)?
	
	func getResult(completion: @escaping (Int) -> Void) {
		self.callBack = completion
		DispatchQueue.main.async { [weak self] in
			self?.performCallback()
		}
	}
	
	func performCallback() {
		callBack?(1)
	}
}

class MemoryViewModel  {
	func callService(completion: @escaping (Int) -> Void) {
		let service = MemoryService()
		service.getResult {
			completion($0)
		}
	}
}
/*:
 In `doMemoryTest()` the print statement isn't being executed. Examine the code above and determine what's causing the issue. Make necessary changes to the above code to resolve the issue.
 */
func doMemoryTest() {
	return
	let memoryViewModel = MemoryViewModel()
	memoryViewModel.callService {
		print("Received memory service response: \($0)")
	}
	// Below can be ignored
	RunLoop.main.run(until: Date().addingTimeInterval(1))
	_ = memoryViewModel
}
/*:
 ---
 ## Errors
 */
class ErrorProneService {
	enum ServiceError: Error {
		case someError
	}
	
	func performNetworkCall(completion: @escaping (Bool, Int?, Error?) -> Void) {
		// Simulating an async network call
		DispatchQueue.main.async {
			if Bool.random() {
				// Call succeeded. provide a non-null value to completion block
				completion(true, 1, nil)
			} else {
				// Call failed, provide an error the completion block
				completion(false, nil, ServiceError.someError)
			}
		}
	}
}

class ErrorProneViewModel {
	struct Answer {
		let value: Int?
	}
	
	let service = ErrorProneService()
	
	func getAnswer(completion: @escaping (Answer?) -> Void) {
		service.performNetworkCall { didSucceed, value, error in
			if didSucceed {
				Answer(value: value)
			} else if error != nil {
				completion(nil)
			}
		}
	}
}
/*:
 When calling `ErrorProneService.performNetworkCall(completion:)`, the block that is executed contains three parameters. Briefly describe the purpose of each parameter. Identify potential problems that can arise from the implementation of `ErrorProneViewModel.getAnswer(completion:)`. Make appropriate changes to make the API of both ErrorProneService and ErrorProneViewModel more ergonomic and testable.
 */
func doErrorsTest() {
	return
	let errorProneViewModel = ErrorProneViewModel()
	errorProneViewModel.getAnswer {
		if let answer = $0 {
			print("Received error prone service response: \(answer)")
		} else {
			print("Did not receive a service response")
		}
	}
	// Keep main thread running for a bit so that above completion block can execute
	RunLoop.main.run(until: Date().addingTimeInterval(1))
	_ = errorProneViewModel
}
/*:
 ---
 ## Combine
 */
class NotificationPoster {
	static let notification1: Notification.Name = .init("Notification 1")
	static let notification2: Notification.Name = .init("Notification 2")
	
	func startPostingNotifications() {
		post(name: NotificationPoster.notification2, after: .now(), object: 0)
		post(name: NotificationPoster.notification1, after: .now() + 1, object: nil)
		post(name: NotificationPoster.notification1, after: .now() + 2, object: 2)
		post(name: NotificationPoster.notification2, after: .now() + 3, object: 3)
		post(name: NotificationPoster.notification1, after: .now() + 4, object: nil)
		post(name: NotificationPoster.notification2, after: .now() + 5, object: 5)
	}
	
	private func post(name: Notification.Name, after time: DispatchTime, object: Int?) {
		DispatchQueue.main.asyncAfter(deadline: time) {
			NotificationCenter.default.post(name: name, object: object)
		}
	}
}

class NotificationListener {
	
	private let poster = NotificationPoster()
		
	func setupListener() {
		// Write combine subscription here
	}
	
	func startListening() {
		poster.startPostingNotifications()
	}
}
/*:
 In `NotificationListener.setupListener()` write a combine subscription that listens to two different notifications, `NotificationPoster.notification1` and `NotificationPoster.notification2`, and prints the object, only if available. Nil values should be ignored. Executing the `doCombineTest()` function should print the following numbers: _0_, _2_, _3_, and _5_.
 */
func doCombineTest() {
	return
	let notificationListener = NotificationListener()
	notificationListener.setupListener()
	notificationListener.startListening()
	// Below can be ignored
	RunLoop.main.run(until: Date().addingTimeInterval(6))
	_ = notificationListener
}

/*:
 ### Please ignore the below code. It is intended to harness the above code to run it in a playground.
 
 */
PlaygroundPage.current.needsIndefiniteExecution = true

doProtocolsTest()
doMemoryTest()
doErrorsTest()
doCombineTest()
