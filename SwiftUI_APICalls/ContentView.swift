//  SwiftUI_APICalls

import SwiftUI

struct URLImage: View{
    let urlString: String
    
    
    //State allows for redrawing UI when variable is updated
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 70)
                .background(Color.gray)
        }
        else{
            Image("")
                .frame(width: 120, height: 60)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
        
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, _, _ in
            self.data = data
            
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.courses, id: \.self) { course in
                    HStack{
                        URLImage(urlString: course.image)
                            
                        Text(course.name)
                            .bold()
                    }.padding(5)
                }
            }
            .navigationTitle("Current Courses")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
