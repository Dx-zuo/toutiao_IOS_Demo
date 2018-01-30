//
//  WebImage.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/22.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//
import Foundation
import UIKit


private let imageCache = NSCache<NSString, AnyObject>()

public class ILSImageCache
{
    public static func setCacheSize(_numberofitemscachecanhold cacheItem:Int)
    {
        imageCache.totalCostLimit = cacheItem
    }
    public static func removeImageCaches()
    {
        imageCache.removeAllObjects()
        
    }
    
    public static func loadImageusingCache(withUrl urlString : String,completion:@escaping (_ status:Bool?,_ image:UIImage?)->())
    {
        let url = URL(string: urlString)
        
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            
            completion(true,cachedImage)
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                
                completion(false,nil)
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data == nil ? Data() : data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    completion(true,image)
                }
            }
            
        }).resume()
    }
}
// MARK: - Extension For UIImageView
public extension UIImageView
{
    
    public enum AnimationTypes : String
    {
        case hideEffect,dissolve,none
        
    }
    private func setAnimation(input:AnimationTypes)->UIViewAnimationOptions
    {
        switch input {
        case .hideEffect:
            
            return UIViewAnimationOptions.showHideTransitionViews
        case .none:
            return UIViewAnimationOptions.overrideInheritedOptions
        default:
            return UIViewAnimationOptions.transitionCrossDissolve
            
        }
    }
    
    public func loadImageUsingCache(withUrl urlString : String,placeholder:UIImage,animation:AnimationTypes) {
        
        let url = URL(string: urlString)
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            UIView.transition(with: self, duration: 0.2, options: self.setAnimation(input: animation), animations: {
                self.image = cachedImage
            }, completion: nil)
            
            return
        }
        else
        {
            DispatchQueue.main.async {
                self.image = placeholder
            }
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    UIView.transition(with: self, duration: 0.2, options: self.setAnimation(input: animation), animations: {
                        self.image = image
                    }, completion: nil)
                    
                }
            }
            
        }).resume()
    }
}
// MARK: - Extension For UIButton
public extension UIButton
{
    
    public enum AnimationTypes : String
    {
        case hideEffect,dissolve
        
    }
    private func setAnimation(input:AnimationTypes)->UIViewAnimationOptions
    {
        switch input {
        case .hideEffect:
            
            return UIViewAnimationOptions.showHideTransitionViews
        default:
            return UIViewAnimationOptions.transitionCrossDissolve
        }
    }
    
    public func loadImageUsingCache(withUrl urlString : String,placeholder:UIImage,animation:AnimationTypes) {
        
        let url = URL(string: urlString)
        self.setImage(placeholder, for: .normal)
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            
            UIView.transition(with: self, duration: 0.2, options: self.setAnimation(input: animation), animations: {
                self.setImage(cachedImage, for: .normal)
            }, completion: nil)
            
            return
        }
        else
        {
            self.setImage(placeholder, for: .normal)
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                
                self.setImage(placeholder, for: .normal)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    UIView.transition(with: self, duration: 0.2, options: self.setAnimation(input: animation), animations: {
                        self.setImage(image, for: .normal)
                    }, completion: nil)
                    
                }
            }
            
        }).resume()
    }
}

