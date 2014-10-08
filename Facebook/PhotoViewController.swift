//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Jessica Jarvis on 10/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    // VARS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var actionsImageView: UIImageView!
    @IBOutlet weak var doneImageView: UIImageView!
    var image: UIImage!
    var scrollAmount: CGFloat!
    var imageOrigin: CGFloat!


    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        imageView.center = view.center
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        imageView.frame.size.width = 320
        imageView.hidden = true
        scrollView.contentSize = CGSize(width: 320, height: 700)
        scrollView.delegate = self
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        scrollAmount = 0
    }

    
    // VIEW DID APPEAR
    override func viewDidAppear(animated: Bool) {
        // SETTING THE IMAGE BASED ON THE PASS FROM THE OTHER VIEW CONTROLLER

                imageView.hidden = false
        
    }

    // RANDO ADDED BY XCODE
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // FANCY SCROLL
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        scrollAmount = scrollView.contentOffset.y
        scrollView.backgroundColor = UIColor(white: 0, alpha: ((100-abs(scrollAmount))/100))
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        doneImageView.hidden = true
        actionsImageView.hidden = true
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            if (abs(scrollAmount)) > 75 {
                dismissViewControllerAnimated(true, completion: nil)
                println("100")
            }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        doneImageView.hidden = false
        actionsImageView.hidden = false
    }
    
    
    //DISMISS
    @IBAction func onDoneTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
