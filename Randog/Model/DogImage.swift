//
//  Dog.swift
//  Randog
//
//  Created by Abdelrahman on 7/10/20.
//  Copyright © 2020 Abdelrahman. All rights reserved.
//

import Foundation
import UIKit

struct DogImage: Codable {
    let message: String
    let status: String
    
    
    static func requestRandomImage(breed: String, completiotnHandler: @escaping (DogImage?, Error?) -> Void){
        let randomImageUrl = K.endpoint.randomImageForBreed(breed).url
        print(randomImageUrl)
        let task = URLSession.shared.dataTask(with: randomImageUrl) { (data, response, error) in
            guard let saveData = data else {
                completiotnHandler(nil, error)
                return
            }
        
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: saveData)
            completiotnHandler(imageData, nil)
            print(imageData)
        }
        task.resume()
    }
    
    static func performRequest(completionHandler: @escaping ([String], Error?) -> Void){
        let listofAllBreedsUrl = K.endpoint.listOfAllBreeds.url
        let task = URLSession.shared.dataTask(with: listofAllBreedsUrl) { (data, response, error) in
            guard let saveData = data else {
                completionHandler([], error)
                return
            }
            print(saveData)
            let decoder = JSONDecoder()
            do {
                let breedsList = try decoder.decode(BreedList.self, from: saveData)
                let breedsArr = breedsList.message.keys.map({$0})
                completionHandler(breedsArr, nil)
            } catch {
                print("Error Decoding: \(error)")
            }
        }
        task.resume()
    }
    static func performImageRequest(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let saveData = data else {
                completionHandler(nil, error)
                return
            }
            let image = UIImage(data: saveData)
            completionHandler(image, nil)
        }
        task.resume()
    }
}
