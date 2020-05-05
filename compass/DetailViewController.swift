//
//  DetailViewController.swift
//  compass
//
//  Created by Christopther Garcia on 5/4/20.
//  Copyright © 2020 Mac Cooper. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    //variables
    var name = "" //String
    var phoneNumber = "" //String
    var price = "" // String
    var reviewCount = 0 // int
    var image: URL! // imageURL
    var address = "" //location.address
    var city = "" // location.city
    var photos = [String]() // object[] of image URLs
    var imageSize = 0 // Int
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main Image Resizing
        let data = try? Data(contentsOf: image!)
        if let imageData = data {
            let newImage = resizeImage(image: UIImage(data:imageData)!, newWidth: 374)
            mainImage.image = newImage
        }
        
        nameLabel.text = name
        priceLabel.text = price
        //phoneNumber.text = phoneNumber
        addressLabel.text = address
        cityLabel.text = phoneNumber
        reviewsLabel.text = String(reviewCount)
        
//        let firstImageURL = URL(string: photos[0])
//        firstImage.af_setImage(withURL: firstImageURL!)
        
        if (imageSize == 1) {
            let firstImageURL = URL(string: photos[0])
            print(photos[0])
            firstImage.af_setImage(withURL: firstImageURL!)
        }
        else if (imageSize == 2) {
            let firstImageURL = URL(string: photos[0])
            let secondImageURL = URL(string: photos[1])
            print(photos[1])
            firstImage.af_setImage(withURL: firstImageURL!)
            firstImage.af_setImage(withURL: secondImageURL!)
        }
        else if (imageSize == 3) {
            let firstImageURL = URL(string: photos[0])
            let secondImageURL = URL(string: photos[1])
            let thirdImageURL = URL(string: photos[2])
            print(photos[2])
            firstImage.af_setImage(withURL: firstImageURL!)
            firstImage.af_setImage(withURL: secondImageURL!)
            firstImage.af_setImage(withURL: thirdImageURL!)
        }
    
        
        
        
        
    }
    
    //helper functions
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage
    {
        let scale = newWidth / image.size.width; let newHeight = image.size.height * scale;
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight));
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight));
        let newImage = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
        
        return newImage!
        
    }

}
