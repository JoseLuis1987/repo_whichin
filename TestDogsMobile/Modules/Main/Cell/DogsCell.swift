//
//  DogsCell.swift
//  CasoIOS-JoseLuis
//
//  Created by Jose Luis on 16/03/22.
//  Copyright © 2021 Jose Luis. All rights reserved.
//

import UIKit

class DogsCell: UITableViewCell {
    @IBOutlet weak var nameDog: UILabel!
    @IBOutlet weak var descriptionDog: UILabel!
    @IBOutlet weak var ageDog: UILabel!
    @IBOutlet weak var imageDog: UIImageView!
    @IBOutlet weak var contentViewSecond: UIView!
    var dogData : Dog? {
        didSet {
            guard dogData != nil else {
                return
            }
            nameDog.text =  dogData?.dogName
            descriptionDog.text = dogData?.strDescription
            if let almostAge = dogData?.age {
                ageDog.text =   String(format: "Almost %d years", almostAge)
            }
           guard let imageUrl:URL = URL(string: dogData?.dogImage ?? "") else {
               return
           }
            imageDog.loadImge(withUrl: imageUrl)
        }
    }
     func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameDog.numberOfLines = 0
        descriptionDog.numberOfLines = 0
        nameDog.textColor = UIColor.darkGray
        descriptionDog.textColor = UIColor.fontColor2()
        ageDog.textColor = UIColor.fontColor3()
        imageDog.layer.cornerRadius = 10
        imageDog.layer.masksToBounds = false
        contentViewSecond.layer.cornerRadius = 6
        contentViewSecond.layer.masksToBounds = false
        contentViewSecond.backgroundColor = UIColor.fontColor1()
        imageDog.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
      //  resizeImage(image: imageDog.image ?? UIImage(named: "portrait-placeholder") , targetSize: CGSize(width: 98, height: 120))
    }
}
