import UIKit

class VSettings:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CSettings!
    weak var collection:UICollectionView!
    
    convenience init(controller:CSettings)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collection:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        self.collection = collection
        
        addSubview(collection)
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MSettingsMenuItem
    {
        let item:MSettingsMenuItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: col del
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let item:MSettingsMenuItem = modelAtIndex(indexPath)
        let cell:VSettingsCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            item.reusableIdentifier,
            forIndexPath:
            indexPath) as! VSettingsCell
        
        item.config(cell, controller:self)
        
        return cell
    }
}