import SwiftUI
struct RowItem: Identifiable {
    let id = UUID()
    
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

struct EbayContentView: View {
    var body: some View {
        VStack {
            List {
                ToolbarView()
                Spacer()
                ForEach(list) { item in
                    RowView(rowItem: item)
                }
            }
        }
    }
}


struct RowView:View {
    let rowItem:RowItem
    var body: some View {
        HStack {
            Text(rowItem.title)
                .font(.caption)
                .foregroundColor(.black)
            Spacer()
            Button {
                
            } label: {
                Image(rowItem.imageName)
                    .resizable()
            }

        }
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
        HStack {
            Text("SCI-FI Game")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: Images.star.rawValue)
                        .resizable()
                }
                Button {
                    
                } label: {
                    Image(systemName: Images.more.rawValue)
                        .resizable()
                }
            }
            
        }
    }
}

