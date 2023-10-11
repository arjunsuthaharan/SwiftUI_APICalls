//
//  ViewModel.swift
//  SwiftUI_APICalls
//
//  Created by Arjun Suthaharan on 2023-10-11.
//

import Foundation
import SwiftUI

struct Course: Hashable, Codable {
    let name: String
    let image: String
}

class ViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    
    func fetch(){
        
        // creating url string for fetching JSON data
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else{
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
                DispatchQueue.main.async{
                    self?.courses = courses
                }
            
        }
            catch{
                print("Json decoding error")
            }
        }
        
        task.resume()
    }
}
