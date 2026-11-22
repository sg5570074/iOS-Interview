//
//  ChatGPTUIView.swift
//  AppDeveloper
//
//  Created by Shivam on 02/04/26.
//

import SwiftUI
import Combine

//struct ChatGPTUIView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    ChatGPTUIView()
//}


//Use @StateObject when your SwiftUI view owns the ObservableObject and needs to keep it alive across re-renders.
//Use @ObservedObject when your view depends on an object owned elsewhere — for example, when it’s passed from a parent view.


// MARK: - Updating Value in SwiftUI View: SwiftUI views are declarative, so we cannot perform assignments inside the body. Side effects must be done using lifecycle modifiers like .onAppear, .task, or user actions.”

//class HotelViewModel: ObservableObject {
//    @Published var title: String = "Expedia Hotel"
//}
//
//struct HotelView: View {
//    @StateObject private var viewModel = HotelViewModel()
//    @State private var state = ""
//
//    var body: some View {
//        VStack {
//          //  viewModel.title = "sadfs"
//            Text(viewModel.title)       // 👈 Access the value
//            TextField("Enter title", text: $viewModel.title)  // 👈 Pass a binding
//            Button("") {
//                viewModel.title = "New Title"
//            }
//        }.onAppear {
//            viewModel.title = "sadfs"
//        }.task {
//            await MainActor.run {
//                state = "Shibam"
//            }
//        }
//    }
//}


// MARK: - Preference Key: A PreferenceKey is a mechanism in SwiftUI that allows child views to pass data up to their parent views.It’s often used with .preference() and .onPreferenceChange() for layout-related communication, like reporting size, position, or scroll offset.

////Step 1: Define a PreferenceKey
struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        // Combine or replace values when multiple children write
        value = nextValue()
    }
}

//
//
////Step 2: Child View Writes the Preference
struct ChildView: View {
    var body: some View {
        Text("Hello Expedia!")
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geo.size)
                }
            )
    }
}
//

//
////Step 3: Parent View Reads the Preference
//struct ParentView: View {
//    @State private var childSize: CGSize = .zero
//
//    var body: some View {
//        VStack {
//            ChildView()
//                .onPreferenceChange(SizePreferenceKey.self) { newSize in
//                    childSize = newSize
//                }
//
//            Text("Child width: \(childSize.width)")
//        }
//    }
//}


// MARK: - can we use @state in place of @observed object ?

//@State only observes changes to the variable itself, not to its internal properties.
//When viewModel.name changes, SwiftUI doesn’t know it needs to refresh the view.
//class ProfileViewModel: ObservableObject {
//    @Published var name = "Abhinav"
//}
//
//struct ProfileView: View {
//    @State var viewModel =  ProfileViewModel()
//
//    var body: some View {
//        Text(viewModel.name)
//    }
//}




//MARK: - ✅ Example: Display list of images in SwiftUI

struct ImageListView: View {
    // Sample image URLs
    let imageURLs = [
        "https://picsum.photos/200/300",
        "https://picsum.photos/250/300",
        "https://picsum.photos/220/320",
        "https://picsum.photos/230/330"
    ]

    var body: some View {
        NavigationView {
            List(imageURLs, id: \.self) { urlString in
                AsyncImage(url: URL(string: urlString)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // shows loader while downloading
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    case .failure:
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .frame(height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
                .listRowInsets(EdgeInsets()) // removes padding
            }
            .navigationTitle("Random Images")
        }
    }
}

//AsyncImage (available from iOS 15+) handles downloading and caching automatically.
//You can easily replace the static imageURLs with API data later.
//The ProgressView() provides a loading indicator.
//You can also use ScrollView instead of List if you prefer a grid or flexible layout.



//MARK: - Actors | Task | Task.Deatched

actor Counter {
    var value = 0

    func increment() {
        value += 1
    }
}

//Each actor has its own serial executor (like a private queue).
//Access to stored properties is implicitly async.


//@MainActor
//class ViewModel: ObservableObject {
//    @Published var text = ""
//}
//MainActor is a special global actor:
//
//Executes on main thread
//Used for UI-related state and tasks
//Prevents background thread UI updates

func testTask1() {
    Task {
        print(Thread.isMainThread) // ❌ false (background thread)
    }
}

func testTask2() {
    Task {
        await MainActor.run {
           // self.text = "Updated"
        }
    }
}


func testTaskDetached() {
    Task.detached {
        print(Thread.isMainThread) // always false
    }
    Task.detached {
       // let data = await fetch()
        await MainActor.run {
          //  self.text = data
        }
    }
    
}
//Runs in background
//Does not follow MainActor isolation
//Cannot update UI unless manually switching:


//TaskGroup with MainActor

//@MainActor
//func loadAll() async {
//    await withTaskGroup(of: String.self) { group in
//        
//        for id in [1, 2, 3] {
//            group.addTask {
//                await fetchData(id)   // 👈 runs in background
//            }
//        }
//
//        for await item in group {
//            print(item)   // 👈 Back on main actor
//        }
//    }
//}

//By default, TaskGroup inherits the actor of the function it is in.
//child tasks automatically escape the main actor to run concurrently
//But the group function itself (loadAll()) still runs on MainActor
//Results merge back safely on main thread


//@MainActor
//class ViewModel1 {
//    var title: String = ""
//
//    func loadData() {
//        print(Thread.isMainThread) // ✅ always true
//    }
//}

//if we write this(@MainActor) then all properties and functions inside class are run in main Actor ?
//All of these are MainActor-isolated:
//
//Stored properties (title)
//Methods (loadData())
//Computed properties
//Subscript



//Task {
//    print(Thread.current)   // Thread A
//
//    let data = await fetchUser()
//    print(Thread.current)   // Could be Thread B
//}

//A Task:
//
//Begins on Thread A
//Suspends at await
//Frees Thread A
//Resumes on Thread B (or main thread, or any executor)
//


//MARK: - 🧠 What is withCheckedContinuation?
//withCheckedContinuation lets you turn a callback-based API into an async/await API.

//Old API (callback-based)
//func loadData(completion: @escaping (String) -> Void) {
//    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//        completion("Data loaded")
//    }
//}

//New API (async/await using withCheckedContinuation)
//func loadData() async -> String {
//    await withCheckedContinuation { continuation in
//        loadData { result in
//            continuation.resume(returning: result)
//        }
//    }
//}

//What happens step-by-step:
//Async function reaches await
//Task is suspended
//Old callback runs
//continuation.resume(...) is called
//Task resumes from where it left off


// MARK: - How to cancel the Task :

// Task can be cancel in may ways:


/*
 You called task.cancel(). The task is still running. This trips up almost everyone moving to async/await.
Cancellation in Swift is cooperative. cancel() doesn't stop anything. It flips a flag (isCancelled) and politely asks the task to wind down. If your code never checks that flag, it runs to completion anyway.
A lot of built-in calls check for you. Task.sleep throws on cancel, URLSession's async methods throw, structured child tasks propagate it. But the moment you write your own loop or a chunk of CPU work, you're on your own. That for-loop chewing through frames will finish every last one after you cancelled it.
The fix is to ask. Drop a try Task.checkCancellation() (or an if Task.isCancelled check) inside loops and before expensive steps, and the work stops where you actually want it to.
Mental model: cancel() is a request, not a kill switch. Cooperative cancellation is the whole design, and once it clicks, a lot of "why is this still running" bugs disappear.
 */

//1> You manually cancel it

//let task = Task {
//    print(Task.isCancelled) // false initially
//}
//
//task.cancel() // 👈 cancellation happens here

//👉 After this:
//Task.isCancelled → true
//Task.checkCancellation() → throws error


//2. Parent task is cancelled (Structured Concurrency)
//Task {
//    await withTaskGroup(of: Void.self) { group in
//        group.addTask {
//            print(Task.isCancelled) // becomes true if parent cancelled
//        }
//    }
//}
//👉 Cancelling parent → children also get cancelled


//3. SwiftUI / system cancels it automatically
//.task {
//    await loadData()
//}
//👉 This task gets cancelled when:
//View disappears
//State changes causing re-render

//Task {
//    for i in 1...1000 {
//        try Task.checkCancellation()
//        print(i)
//    }
//}

//Creating a task and calling cancel() marks it as cancelled, but does not stop execution automatically.
//Cancellation in Swift is cooperative — tasks must check their cancellation status using Task.isCancelled or Task.checkCancellation().
//Many async APIs like URLSession are cancellation-aware and throw CancellationError automatically.



//5️⃣ What if fetchData() is cancellable?
//Many system APIs already check cancellation internally.
//Examples:
//URLSession.data(for:)
//Task.sleep
//AsyncSequence
//
//If the task is cancelled:
//
//These APIs throw CancellationError
//Your task exits automatically

//6️⃣ Real Example: Image download with cancellation support ✅
//var imageTask: Task<Void, Never>?
//
//func startDownload(url: URL) {
//    imageTask = Task {
//        do {
//            let image = try await downloadImage(from: url)
//            await MainActor.run {
//                self.imageView.image = image
//            }
//        } catch is CancellationError {
//            print("Image download cancelled")
//        } catch {
//            print("Download failed:", error)
//        }
//    }
//}
//
//func cancelDownload() {
//    imageTask?.cancel()
//}



//MARK: - @Observable (New Swift Observation)
//@Observable is the new system (iOS 17+) that replaces ObservableObject + @Published.
//No need for:ObservableObject, @Published
//It automatically observes property changes.

//import Observation
//
@Observable
class HotelVM {
    var hotels: [String] = []
}

struct HotelView: View {
    @State private var vm = HotelVM()

    var body: some View {
        List(vm.hotels, id: \.self) { Text($0) }
    }
}

//✅ @ObservedObject works only with ObservableObject (Combine-based)
//❌ @Observable is a different system (Observation-based)

//✅ If using @Observable, what do we use in the View?
//1) If the view owns the model:
//Use @State

//import Observation
//import SwiftUI
//
//@Observable
//class HotelVM {
//    var hotels: [String] = []
//}
//
//struct HotelView: View {
//    @State private var vm = HotelVM()   // ✅ correct
//
//    var body: some View {
//        List(vm.hotels, id: \.self) { Text($0) }
//    }
//}

//👉 @State ensures:
//vm is created once
//Not recreated on every render
//➡️ So yes:
//
//“No new instance is created” ✅
//@State + @Observable  ≈  @StateObject + ObservableObject

//if we will not used anything, simple var in View, then it will rerender evertime, bheave like @observedObject

//2) If model is passed from parent:
//Use normal let / var (no wrapper) OR @Bindable
//struct ChildView: View {
//    let vm: HotelVM   // ✅ fine (read-only)
//    
//    var body: some View {
//        Text(vm.hotels.count.description)
//    }
//}
//
//struct ChildView: View {
//    @Bindable var vm: HotelVM   // ✅ best for editing
//}
// Like earlier we were using @Binding for chilviews

//What happens if we use @ObservedObject with @Observable?
//@Observable
//class HotelVM {
//    var hotels: [String] = []
//}
//
//struct HotelView: View {
//    @ObservedObject var vm = HotelVM()   // ❌ wrong
//}

//🚨 Result:
//It will NOT compile, because:
//@ObservedObject expects a type conforming to ObservableObject
//@Observable types do not conform to ObservableObject
//
//So you’ll get an error like:
//Type 'HotelVM' does not conform to protocol 'ObservableObject'

//🧠 Simple Rule
//If your model uses    Then view uses
//ObservableObject + @Published  --->   @ObservedObject / @StateObject
//@Observable  --->  @State / @Bindable / Environment()

//🎯 Interview-ready answer
//
//If we use @Observable, we don’t use @ObservedObject because @ObservedObject is designed for Combine’s ObservableObject. The Observation framework uses a different mechanism. Trying to use @ObservedObject will cause a compile-time error since the type doesn’t conform to ObservableObject.


//MARK: -  @Bindable

//@Bindable is used when you pass an entire @Observable object to a child view and want two-way binding to its properties.

//Example (@Observable + @Bindable)

//import Observation
//
//@Observable
//class ProfileVM {
//    var name: String = ""
//    var age: Int = 0
//}

//struct ParentView: View {
//    @State private var vm = ProfileVM()
//
//    var body: some View {
//        ChildView(vm: vm)
//    }
//}
//
//struct ChildView: View {
//    @Bindable var vm: ProfileVM
//
//    var body: some View {
//        TextField("Name", text: $vm.name)
//        Stepper("Age: \(vm.age)", value: $vm.age)
//    }
//}


// MARK: - .environment() : If you’re using the new Observation framework (@Observable) and storing your view model with @State, you don’t pass it via .environmentObject.

//2️⃣ New (Observation framework)
//@Observable
//@State, @Bindable
//.environment(_:) ✅ (new way)


@Observable
class ViewModel {
    var name: String = ""
}

struct ParentView: View {
    @State private var vm = ViewModel()
    
    var body: some View {
        ChildView()
            .environment(vm) // ✅ correct
    }
}

struct ChildView: View {
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        Text(vm.name)
    }
}


//@Environment(ViewModel.self) var vm
//@Environment var vm:ViewModel

//❌ Above both are Not the same

//| Syntax                           | Valid?  | Use case                         |
//| -------------------------------- | ------  | -------------------------------- |
//| `@Environment(ViewModel.self)`   | ✅      | Injected objects (`@Observable`) |
//| `@Environment var vm: ViewModel` | ❌      | Not valid                        |
//| `@Environment(\.keyPath)`        | ✅      | Used System values                    |


//MARK: - How to avoid multiple API calls in .onAppear?
//✅ 1. Use a flag (simple & effective)
//@State private var hasLoaded = false
//
//var body: some View {
//    Text("Hello")
//        .onAppear {
//            guard !hasLoaded else { return }
//            hasLoaded = true
//            loadData()
//        }
//}

//✅ 2. Use @StateObject ViewModel (BEST practice)
//@StateObject var viewModel = ViewModel()
//
//var body: some View {
//    Text(viewModel.title)
//        .onAppear {
//            viewModel.loadData()
//        }
//}
//class ViewModel: ObservableObject {
//    private var hasLoaded = false
//
//    func loadData() {
//        guard !hasLoaded else { return }
//        hasLoaded = true
//
//        // API call
//    }
//}
//✅ 4. Use .task(id:) (advanced & clean)
//    .task(id: viewModel.id) {
//        await viewModel.loadData()
//    }
//👉 Runs only when id changes




// MARK: - CVent
//Consume the API https://www.gutenberg.org/files/1342/1342-0.txt using URLSession.
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
//func getData() async throws -> (String, Int) {
//    guard let url = URL(string: "https://www.gutenberg.org/files/1342/1342-0.txt") else {
//        return ("", 0)
//    }
//    
//    let manager = APIMAnager()
//    let store = ResultStore()
//    
//    async let task1: Void = {
//        let text = try await manager.getAPI(url)
//        let processed = sliceData(.thirtyK, string: text)
//        await store.append(processed)
//    }()
//    
//    async let task2: Void = {
//        let text = try await manager.getAPI(url)
//        let processed = sliceData(.fortyK, string: text)
//        await store.append(processed)
//    }()
//    
//    _ = try await (task1, task2)
//    
//    let final = await store.getFinal()
//    return (final, final.count)
//}


//🔹 5. ViewModel (SwiftUI Binding)
//import SwiftUI
//
//@MainActor
//class BookViewModel: ObservableObject {
//    @Published var text: String = ""
//    @Published var count: Int = 0
//    
//    func load() {
//        Task {
//            do {
//                let (result, count) = try await getData()
//                self.text = result
//                self.count = count
//            } catch {
//                print("Error:", error)
//            }
//        }
//    }
//}

//🔹 6. SwiftUI View
//struct ContentView: View {
//    @StateObject private var vm = BookViewModel()
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            
//            Text("Character Count: \(vm.count)")
//                .font(.headline)
//            
//            ScrollView {
//                Text(vm.text)
//                    .font(.caption)
//                    .padding()
//            }
//        }
//        .onAppear {
//            vm.load()
//        }
//    }
//}


//struct Button<Content: View>: View {
//    var body: some View {
//        
//    }
//}

//Here
//<Content: View> (🔥 MOST IMPORTANT)
//👉 This is a Generic Type
//
//“Content is a type that must conform to View”
//💡 Meaning
//Content can be any SwiftUI view
//But must follow View protocol

// Example
//Text("Hello")      // View
//Image("icon")      // View
//VStack { ... }     // View



// MARK: -


