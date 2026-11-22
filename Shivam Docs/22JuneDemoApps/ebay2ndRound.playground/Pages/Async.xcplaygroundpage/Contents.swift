import Foundation
import PlaygroundSupport
/*:
 # Async Questions
 ## Instructions
 Please refrence the AsyncMonitoring.swift file for the below two tests.
 
 For `doBasicAsyncTest()`, write code in `DataListener.getCurrentValue()` that calls `Monitor.getCurrentValue(completion:)` and returns the value as an async result.
 
 For `doAsyncStreamTest()`, write code in `DataListener.listen()` that returns an AsyncStream which yields values that are provided via `Monitor`'s callback.
 
 For these tests, it may be helpful to split between two editors. This can be done via the Add Editor on Right button in the top right corner of this playground.
 
 ![Add Editor on Right button](AddEditor.png)
 */
@MainActor func doBasicAsyncTest() async {
	let listener = DataListener()
	let currentValue = await listener.getCurrentValue()
	print("Current value: \(currentValue)")
}

@MainActor func doAsyncStreamTest() async {
	return
	let listener = DataListener()
	await listener.continuouslyListen()
}
/*:
 ### Please ignore the below code. It is intended to harness the above code to run it in a playground.
 
 */
PlaygroundPage.current.needsIndefiniteExecution = true

Task { @MainActor in
	await doBasicAsyncTest()
	await doAsyncStreamTest()
}
