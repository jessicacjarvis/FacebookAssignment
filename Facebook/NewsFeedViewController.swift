//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    // VARIABLES
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var mainWeddingImageView: UIImageView!
    @IBOutlet weak var secondWeddingImageView: UIImageView!
    @IBOutlet weak var thirdWeddingImageView: UIImageView!
    @IBOutlet weak var fourthWeddingImageView: UIImageView!
    @IBOutlet weak var fifthWeddingImageView: UIImageView!
    var imageViewToSegue: UIImageView!
    var isPresenting: Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // SCROLL VIEW SIZING
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // SCROLL VIEW
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    // TAP GESTURE
    @IBAction func onTap(gestureRecognizer: UITapGestureRecognizer) {
        imageViewToSegue = gestureRecognizer.view as UIImageView
        performSegueWithIdentifier("feedToPhoto", sender: self)

    }
    
    // PASSING INFO TO OTHER VIEW CONTROLLER
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        destinationViewController.image = self.imageViewToSegue.image
        
    }
    
    // TRANSITION DELEGATE METHODS 1
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    // TRANSITION DELEGATE METHODS 2
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    // TRANSITION DELEGATE METHODS 3
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        
        // TO
        if (isPresenting) {
            var window = UIApplication.sharedApplication().keyWindow
            var frame = window.convertRect(imageViewToSegue.frame, fromView: scrollView)
            var copyImageViewToSegue = UIImageView(frame: frame)
            copyImageViewToSegue.image = imageViewToSegue.image
            window.addSubview(copyImageViewToSegue)
            toViewController.view.alpha = 0
            containerView.addSubview(toViewController.view)
            copyImageViewToSegue.contentMode = imageViewToSegue.contentMode
            copyImageViewToSegue.clipsToBounds = true
            
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                

                toViewController.view.alpha = 1
                copyImageViewToSegue.frame.size.width = 320
                copyImageViewToSegue.frame.size.height = 320 * (copyImageViewToSegue.image!.size.height / copyImageViewToSegue.image!.size.width)
                copyImageViewToSegue.center = self.view.center
                
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    copyImageViewToSegue.removeFromSuperview()
            }
            
        // FROM
        } else {
            var window = UIApplication.sharedApplication().keyWindow
            var copyImageViewToSegue = UIImageView(image: imageViewToSegue.image)
            copyImageViewToSegue.image = imageViewToSegue.image
            copyImageViewToSegue.frame.size.width = 320
            copyImageViewToSegue.frame.size.height = 320 * (copyImageViewToSegue.image!.size.height / copyImageViewToSegue.image!.size.width)
            copyImageViewToSegue.center.x = self.view.center.x
            copyImageViewToSegue.contentMode = UIViewContentMode.ScaleAspectFill
            copyImageViewToSegue.clipsToBounds = false
            var photoViewController = fromViewController as PhotoViewController
            copyImageViewToSegue.center.y = window.center.y - photoViewController.scrollAmount


            window.addSubview(copyImageViewToSegue)
            fromViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                copyImageViewToSegue.frame = window.convertRect(self.imageViewToSegue.frame, fromView: self.scrollView)
                fromViewController.view.alpha = 0
                
    
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
                    copyImageViewToSegue.removeFromSuperview()
            }
        }
    }
    


    
    
}
