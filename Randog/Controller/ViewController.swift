//
//  ViewController.swift
//  Randog
//
//  Created by Abdelrahman on 7/6/20.
//  Copyright © 2020 Abdelrahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds: [String] = []
    func handleImageResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    func handleListofAllBreedsRequest(breedsArray: [String], error: Error?) {
        self.breeds = breedsArray
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        guard let saveURL = URL(string: dogImage?.message ?? "") else {
            return
        }
        DogImage.performImageRequest(url: saveURL, completionHandler: self.handleImageResponse(image:error:))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        DogImage.performRequest(completionHandler: handleListofAllBreedsRequest(breedsArray:error:))
        
        //            DogImage.performImageRequest(url: saveURL, completionHandler: self.handleImageResponse(image:error:) )
        
        //                        print(saveData)
        //                        do{
        //
        //                            let jsonObj = try JSONSerialization.jsonObject(with: saveData, options: []) as! [String: Any]
        //                            let message = jsonObj["message"] as! String
        //                            let url = URL(string: message)
        //                            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        //                            DispatchQueue.main.async {
        //                                self.imageView.image = UIImage(data: data!)
        //
        //                            }
        //
        //                        } catch {
        //                            print("Error parsing data \(error)")
        //                        }
        ////                       }
    }
}
// MARK:- PickerView Data Source Methods
extension ViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
// MARK:- PickerView Delegate Methods
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogImage.requestRandomImage(breed: breeds[row] , completiotnHandler: handleRandomImageResponse(dogImage:error:))
    }
    
}

