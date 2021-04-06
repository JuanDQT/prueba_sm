//
//  ImageSliderController.swift
//  PruebaSM
//
//  Created by Juan on 6/4/21.
//

import UIKit
import ImageSlideshow
import ImageSlideshowKingfisher

// Controlador slider imagenes
class ImageSliderController: UIViewController {
    
    @IBOutlet weak var slider: ImageSlideshow!
    var groupId: Int = 0
    
    override func viewDidLoad() {
        slider.slideshowInterval = 0
        slider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slider.contentScaleMode = UIViewContentMode.scaleAspectFill

        slider.activityIndicator = DefaultActivityIndicator()
        slider.delegate = self

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ImageSliderController.didTap))
        slider.addGestureRecognizer(recognizer)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(responseImages(_:)), name: Notification.Name(rawValue: "GET_IMAGES"), object: nil)
        SyncData().getMedia(groupId)
    }
    
    @objc func responseImages(_ notification: Notification) {
        let data = notification.userInfo as! [String: [KingfisherSource]]
        slider.setImageInputs(data["items"]!)
    }
    
    @objc func didTap() {
        let fullScreenController = slider.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
    }
}

extension ImageSliderController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
