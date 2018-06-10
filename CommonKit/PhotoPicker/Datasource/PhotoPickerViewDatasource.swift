//
//  PhotoPickerViewDatasource.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension PhotoPickerView {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.cellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellSpacing + 1.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: return self.assetManager.currentAlbum?.assets.count ?? 0
        case 1: return self.assetManager.albums.count
        default: return 0
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if ( collectionView.tag == 0 ) {
            
            let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
            
            cell.tag = indexPath.row
            cell.number = self.selectedAssetIndexes.index(of: cell.tag)
            
            self.photoManager.requestImage(
                for: self.assetManager.currentAlbum!.assets.object(at: indexPath.row),
                targetSize: self.cellSize,
                contentMode: .aspectFill,
                options: nil,resultHandler: {
                    (result, info) -> () in
                    cell.image = result
            })
            
            return cell
            
        } else {
            
            let cell: AlbumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
            
            cell.tag = indexPath.row
            cell.title = self.assetManager.albums[indexPath.row].name
            cell.image = self.assetManager.albums[indexPath.row].thumbnail
            
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
}
