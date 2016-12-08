//
//  DetailViewController.swift
//  ElementsMidterm
//
//  Created by Kareem James on 12/8/16.
//  Copyright © 2016 Kareem James. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedObject: ElementObject!
    
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var melting: UILabel!
    @IBOutlet weak var boiling: UILabel!
    
    @IBAction func favorite(_ sender: AnyObject) {
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedObject.name
        self.symbol.text = "Symbol: \(selectedObject.symbol)"
        self.number.text = "Number: \(selectedObject.number)"
        self.weight.text = "Weight: \(selectedObject.weight)"
        self.boiling.text = "Boiling Point: \(selectedObject.boiling)"
        self.melting.text = "Melting Point: \(selectedObject.melting)"

        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(selectedObject.symbol).png") { (data: Data?) in
            if let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    
                    self.largeImage.image = validImage
                    self.largeImage.setNeedsLayout()
                }
            }
        }

    
    
    
    
    }

       

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
