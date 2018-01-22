//
//  WebImage.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/22.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class URLImageView: UIImageView {
    
    let cache: NSCache<NSString, UIImage>
    
    var request: URLSessionDataTask?
    
    var placeholder: UIImage?
    
    var fadeIn: Bool = true
    
    var fadeDuration: Double = 0.3
    
    var startAlpha: CGFloat = 0.0
    
    fileprivate var callable: (() -> Void)?
    
    init() {
        cache = NSCache()
        
        super.init(image: nil)
    }
    
    init(url: String, placeholder: UIImage? = nil) {
        cache = NSCache()
        
        self.placeholder = placeholder
        
        super.init(image: placeholder)
        
        guard let link = URL(string: url) else { return }
        
        from(url: link)
    }
    
    required init?(coder aDecoder: NSCoder) {
        cache = NSCache()
        super.init(coder: aDecoder)
    }
    
    public func setPlaceholderImage(_ img: UIImage) {
        placeholder = img
    }
    
    public func from(url: URL?, completionHandler: (() -> Void)? = nil) -> Void {
        
        if let _: URL = url {
            
            if fadeIn {
                alpha = 0.0
            }
            
            if let fromCache: UIImage = cache.object(forKey: url!.absoluteString as NSString) {
                image = fromCache
                if fadeIn {
                    UIView.animate(withDuration: self.fadeDuration, animations: {
                        self.alpha = 1.0
                    })
                }
                callable?()
                return
            }
            
            if let _ = placeholder {
                image = placeholder
            }
            
            let session: URLSession =  URLSession(configuration: URLSessionConfiguration.default)
            
            request = session.dataTask(with: url!) { data, response, error in
                
                guard error == nil else { return }
                
                DispatchQueue.main.async {
                    
                    self.image = UIImage(data: data!)
                    
                    if self.fadeIn {
                        UIView.animate(withDuration: self.fadeDuration, animations: {
                            self.alpha = 1.0
                        })
                    }
                    
                    if let _ = self.image {
                        self.cache.setObject(self.image!, forKey: url!.absoluteString as NSString)
                    }
                    
                    if let callable = completionHandler {
                        callable()
                    } else {
                        self.callable?()
                    }
                    
                }
                
            }
            
            request?.resume()
        }
    }
    
    public func register(completionHandler: @escaping () -> Void) {
        callable = completionHandler
    }
}
