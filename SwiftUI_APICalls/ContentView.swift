//  SwiftUI_APICalls

import SwiftUI

struct Course: Hashable, Codable {
    let name: String
    let image: String
}

class ViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    func fetch(){
        
        // creating url string for fetching JSON data
        guard let url = URL(string: "") else{
            return
        }
        
        // creating variable to store data
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
        // Coverting data to JSON
            do{
                let courses = try JSONDecoder().decode([Course].self, from: data)
            
        }
            catch{
                print("Json decoding error")
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView{
            List{
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
