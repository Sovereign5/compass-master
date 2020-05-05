//
//  ResturantListTableViewController.swift
//  compass
//
//  Created by Christopther Garcia on 4/15/20.
//  Copyright © 2020 Mac Cooper. All rights reserved.
//

import UIKit
import CoreGraphics
import CDYelpFusionKit
import YelpAPI
import BrightFutures

class ResturantListTableViewController: UITableViewController {
    
    // Variables
    var offset = 0
    var fetchMore = false
    var index = 0
    
    var resturantArray = [CDYelpBusiness]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.prepareRestuarants()
        self.loadResturants()
    }
    
    func prepareRestuarants() {
            let appSecret = "jA68XPwLGguQMoeEpcW2DMyw7tMB7MXXhmHcwqW_iRRIdMM3Nx_q-f7RjSMGaeDidFJfv7vNth1urlLXXsMPhNArpXmJNKz-yViahoE8MCmGV9sYTAheSzvqMNNmXnYx"
            
            // Search for 5 dinner restaurants
            let yelpAPIClient = CDYelpAPIClient(apiKey: appSecret)
            yelpAPIClient.cancelAllPendingAPIRequests()
            
            yelpAPIClient.searchBusinesses(byTerm: "Food",
                                           location: "San Francisco",
                                           latitude: nil,
                                           longitude: nil,
                                           radius: 10000,
                                           categories: nil,
                                           locale: .english_unitedStates,
                                           limit: 5,
                                           offset: offset,
                                           sortBy: .rating,
                                           priceTiers: nil,
                                           openNow: true,
                                           openAt: nil,
                                           attributes: nil) { (response) in
                                            if let response = response,
                                                let businesses = response.businesses,
                                                businesses.count > 0{
                                                self.offset = self.offset + 5
                                                for x in businesses {
                                                    self.resturantArray.append(x)
                                                    print(x.name!)
                                                    print(x)
                                                }
                                                DispatchQueue.main.async {
                                                    self.tableView.reloadData()
                                                }
                                            }
            }
            do{
                sleep(1)
            }
    }
    
    func loadResturants() {
        self.tableView.reloadData();
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return resturantArray.count
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resturantCell", for:indexPath) as! ResturantTableViewCell
        print(indexPath)
        let user = self.resturantArray[indexPath.row]
        
                cell.nameLabel.text = user.name
                cell.styleLabel.text = user.categories![0].title
                cell.pricingLabel.text = user.price
                //cell.ratingLabel.text = String(format:"%f", user.rating!)
        
        
                let imageURL = user.imageUrl
                let data = try? Data(contentsOf: imageURL!)
        
                if let imageData = data {
                    let newImage = resizeImage(image: UIImage(data:imageData)!, newWidth: 130)
                    cell.imageURLView.image = newImage
                }
        
        return cell
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        let user = self.resturantArray[index]
    
        vc.name = user.name!
        vc.phoneNumber = user.displayPhone!
        vc.price = user.price!
        vc.reviewCount = user.reviewCount!
        vc.image = user.imageUrl!
        vc.address = user.location!.addressOne!
        //vc.city = user.location!.addressOne!
        
        print(user.photos)
        let size = user.photos?.count
        print(size ?? "error")
        if (size ?? -10 > 0) {
            vc.imageSize = size ?? 0
            vc.photos = user.photos!
        }
    }
    
    
    
    
    // Helper Functions
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage
    {
        let scale = newWidth / image.size.width; let newHeight = image.size.height * scale;
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight));
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight));
        let newImage = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
        
        return newImage!
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchMore = true
        print("fetching more from API!")
        
        prepareRestuarants()
        loadResturants()
        
        fetchMore = false
        
    }
    
}
