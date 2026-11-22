import Foundation

public class Monitor {
	enum Result {
		case value(Int)
		case finished
	}
	
	private var valueToSend = 0
	private var timer: Timer?
	private let callback: ((Result) -> Void)?
	
	init(callBack: ((Result) -> Void)? = nil) {
		self.callback = callBack
	}
	
	deinit {
		timer?.invalidate()
	}
	
	func startMonitoring() {
		// Simple function that uses a timer to send values from 1 to 9, one per second. Afterwards it sends a finished message.
		valueToSend = 1
		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] in
			guard let self, valueToSend > 0 else {
				$0.invalidate()
				return
			}
			guard valueToSend < 10 else {
				callback?(.finished)
				$0.invalidate()
				return
			}
			callback?(.value(valueToSend))
			valueToSend += 1
		}
	}
	
	static func getCurrentValue(completion: @escaping (Int) -> Void) {
		DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
			completion(12)
		}
	}
	
	func stopMonitoring() {
		valueToSend = 0
	}
}

@MainActor
public class DataListener {
	public init() {}
	
	public func getCurrentValue() async -> Int {
		// Write code below that Calls the Monitor.getCurrentValue(completion:) API and
		// returns the value as an async result.
		
		preconditionFailure("Needs implementation")
	}
	
	public func continuouslyListen() async {
		for await result in listen() {
			print("Result \(result)")
		}
		print("Finished")
	}
	
	private func listen() -> AsyncStream<Int> {
//		Write the implementation that returns an AsyncStream which yields its values.
		
		preconditionFailure("Needs implementation")
	}
}
