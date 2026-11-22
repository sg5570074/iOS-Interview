import SwiftUI
import PlaygroundSupport
/*:
 # SwiftUI Exercise
 ## Instructions
 
 In the below `ContentView`, implement and add a `ToolbarView` at the top of the document. Next, add a list of rows containing the title and an icon.
 
 The end result should look like this:
 
 ![Result](SwiftUI-Result.png)
 
 ## Requirements:
 1. Toolbar should support dynamic type.
 2. The content below the toolbar should be centered within its own space.
 3. The padding of the toolbar from the various edges is 16.
 4. Text and buttons adjust their colors to light and dark mode.
 5. Title has `title` font style and is bold.
 5. Buttons have no-op actions.
 6. List must be scrollable.
 */
struct RowItem {
	let title: String
	let imageName: String
}

let list: [RowItem] = [
	.init(title: "Starfield", imageName: "star.slash"),
	.init(title: "Mass Effect", imageName: "sun.horizon"),
	.init(title: "Halo", imageName: "sun.max.circle"),
	.init(title: "Dead Space", imageName: "moon.dust"),
	.init(title: "Star Fox 64", imageName: "staroflife.shield"),
	.init(title: "Destiny", imageName: "arrowtriangle.down"),
	.init(title: "Elite: Dangerous", imageName: "moon.stars.circle")
]

struct ContentView: View {
	var body: some View {
		EmptyView()
	}
}

struct ToolbarView: View {
	/// Names of system image files (SF Symbols)
	enum Images: String {
		case star = "star"
		case more = "ellipsis.circle"
	}

	let backgroundColor = Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))

	var body: some View {
		EmptyView()
	}
}

PlaygroundPage.current.setLiveView(ContentView())
