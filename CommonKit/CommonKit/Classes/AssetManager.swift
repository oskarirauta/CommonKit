//
//  AssetManager.swift
//  CommonKit
//
//  Created by Oskari Rauta on 07/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVFoundation

open class AssetManager {

    open class PhotoAlbumModel {
        
        open var name: String
        open var count: Int
        open var collection: PHAssetCollection
        open var thumbnail: UIImage?
        
        public init(name:String, count:Int, collection:PHAssetCollection, thumbnail: UIImage? = nil) {
            self.name = name
            self.count = count
            self.collection = collection
            self.thumbnail = thumbnail
        }

        open lazy var assets: PHFetchResult<PHAsset> = {
            
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            var _assets: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: self.collection, options: options)
            return _assets
        }()
        
    }
    
    open var albumIndex: Int = 0
    
    open var currentAlbum: PhotoAlbumModel? {
        get { return self.albums.count > self.albumIndex ? self.albums[albumIndex] : nil }
    }
    
    open lazy var albums: Array<PhotoAlbumModel> = {
        [unowned self] in
        var _albums: Array<PhotoAlbumModel> = self.album_source
        return _albums
    }()
    
    private(set) var thumbnail_size: CGSize
    
    internal var album_source: [PhotoAlbumModel] {
        get {
            var _albums: [PhotoAlbumModel] = []
            
            self.albumIndex = 0
            
            let manager: PHImageManager = PHImageManager.default()
            
            let options = PHFetchOptions()
            let fetchOptions = PHFetchOptions()
            let img_opts = PHImageRequestOptions()
            
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            img_opts.isSynchronous = true
            img_opts.deliveryMode = .fastFormat
            
            let userAlbums: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
            let smartAlbums: PHFetchResult<PHAssetCollection>  = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: options)
            
            [smartAlbums, userAlbums].forEach { $0.enumerateObjects{
                object, count, stop in
                
                if let obj = object as PHAssetCollection? {
                    if let first = PHAsset.fetchKeyAssets(in: obj, options: fetchOptions)?.firstObject {
                        let count: Int = PHAsset.fetchAssets(in: obj, options: fetchOptions).count
                        var thumbnail: UIImage? = nil
                        manager.requestImage(
                            for: first,
                            targetSize: self.thumbnail_size,
                            contentMode: .aspectFit,
                            options: img_opts,
                            resultHandler: {
                                image, _ in
                                thumbnail = image
                        })
                        
                        _albums.append(PhotoAlbumModel(
                            name: obj.localizedTitle!,
                            count: count,
                            collection: obj,
                            thumbnail: thumbnail))
                    } } } }
            
            return _albums
        }
    }
    
    public init() {
        self.thumbnail_size = CGSize(width: 80.0, height: 80.0)
    }
    
    public init(size: CGSize) {
        self.thumbnail_size = size
    }
    
}
