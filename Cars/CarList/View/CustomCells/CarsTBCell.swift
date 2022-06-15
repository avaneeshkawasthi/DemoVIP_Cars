//
//  CarsTBCell.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import UIKit
import Kingfisher

class CarsTBCell: UITableViewCell {
    
    @IBOutlet weak var car_Image: UIImageView!
    @IBOutlet weak var car_Title: UILabel!
    @IBOutlet weak var car_Ingress: UILabel!
    @IBOutlet weak var car_Update_date: UILabel!
    
    @IBOutlet weak var image_Height : NSLayoutConstraint!
    
    var dummy_ImageView:UIImageView =  UIImageView()
    var imageURL : String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData( data: Car?) -> Void {
        if let title = data?.title {
            car_Title.text = title
        }
        if let ingress = data?.ingress {
            car_Ingress.text = ingress
        }
        if let dateTime = data?.dateTime {
            car_Update_date.text = self.getFormmatedDateString(date: dateTime)
        }
        if let imageURL = data?.image {
            self.imageURL = imageURL
            let url = URL(string: imageURL)
            let processor = DownsamplingImageProcessor(size: car_Image.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 0)
            dummy_ImageView.kf.indicatorType = .activity
            dummy_ImageView.kf.setImage(
                with: url,
                placeholder: UIImage(),
                options: [
                    .processor(processor),
                    .cacheOriginalImage
                ])
            { result in
                switch result {
                case .success(let value):
                    let urlStr = self.imageURL
                   if value.source.url?.absoluteString == urlStr {
                       self.updateImageSize(downloadedImage: value.image)
                      // KF.shared.storeCachedResponse(value.image, for: urlStr)
                 }
                case .failure(_):
                return;
            }
               
        }
    }
  }
    
    private func updateImageSize( downloadedImage : UIImage?) {
        self.car_Image.image = downloadedImage
        if let image = downloadedImage {
            let ratio = image.size.width / image.size.height
            if car_Image.frame.width > car_Image.frame.height {
                let newHeight = car_Image.frame.width / ratio
                car_Image.frame.size = CGSize(width: car_Image.frame.width, height: newHeight)
                if newHeight > 356 {
                    self.image_Height.constant = newHeight
                }
                else {
                    self.image_Height.constant = 356
                }
               
            }
        }
    }
    //25.05.2018 14:13
    
    private func getFormmatedDateString( date : String ) -> String {
        guard let date_Object = date.toDate(withFormat: "dd.MM.yyyy HH:mm") else {
            return ""
        }
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let GenratedYear = calendar.component(.year, from: date_Object)
        if currentYear - GenratedYear == 0 {
            return "dd MMM,HH:mm"
        }
        else{
            return date_Object.toString(withFormat: "dd MMM, yyyy HH:mm")
        }
    }
}
