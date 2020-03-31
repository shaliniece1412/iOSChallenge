//
//  ImageDownloader.swift
//  SampleTableView
//
//  Created by 922235 on 29/03/20.
//  Copyright © 2020 922235. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    private static let imageCache = NSCache<NSString, UIImage>()

        func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
       
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            if let cachedImage = UIImageView.imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            UIImageView.imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }else{
                            self.image = placeHolder
                        }
                    }
                }
            }).resume()
        }
    }
    
    func setImageFromUrl(ImageURL :String) {
         URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
               if let data = data {
                 self.image = UIImage(data: data)
               }
            }
         }).resume()
      }
}
