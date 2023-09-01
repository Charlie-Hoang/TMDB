//
//  UIIMageView+Ext.swift
//  TMDB
//
//  Created by Charlie on 31/8/23.
//

import UIKit

extension UIImageView {
    func load(url: URL?, placeholder: UIImage?, cache: URLCache? = nil) {
        guard let url = url else {return}
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.startAnimating()
            self.addSubview(indicator)
            indicator.center = self.convert(self.center, from:self.superview)
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                        indicator.removeFromSuperview()
                    }
                }
            }).resume()
        }
    }
}
