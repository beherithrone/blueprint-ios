//
//  CollectionViewImageCell.swift
//  App-iOS
//
//  Copyright © 2015 Sky UK. All rights reserved.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public class CollectionViewImageCell: UICollectionViewCell {
    @IBOutlet var imageOutlet: UIImageView!
    
    var disposeBag: DisposeBag!
    
    var image: Observable<UIImage!>! {
        didSet {
            let disposeBag = DisposeBag()
            
            self.image
                .subscribe(imageOutlet.rx_imageAnimated(kCATransitionFade))
                .addDisposableTo(disposeBag)
            
            self.disposeBag = disposeBag
        }
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = nil
    }

    deinit {
    }
}