import UIKit

class VCreate:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CCreate!
    weak var collection:UICollectionView!
    private let kHeaderHeight:CGFloat = 60
    private let kCollectionBottom:CGFloat = 120
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white:0.98, alpha:1)
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeMake(0, kHeaderHeight)
        flow.footerReferenceSize = CGSizeZero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(0, 0, kCollectionBottom, 0)
        flow.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        let collection:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.backgroundColor = UIColor.clearColor()
        collection.delegate = self
        collection.dataSource = self
        collection.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        collection.registerClass(
            VCreateHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VCreateHeader.reusableIdentifier())
        collection.registerClass(
            VCreateCellTitle.self,
            forCellWithReuseIdentifier:
            VCreateCellTitle.reusableIdentifier())
        collection.registerClass(
            VCreateCellText.self,
            forCellWithReuseIdentifier:
            VCreateCellText.reusableIdentifier())
        collection.registerClass(
            VCreateCellPublish.self,
            forCellWithReuseIdentifier:
            VCreateCellPublish.reusableIdentifier())
        self.collection = collection
        
        addSubview(collection)
        
        let views:[String:AnyObject] = [
            "collection":collection]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func layoutSubviews()
    {
        collection.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MCreateItem
    {
        let item:MCreateItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: col del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let item:MCreateItem = modelAtIndex(indexPath)
        let width:CGFloat = collectionView.bounds.size.width
        let size:CGSize = CGSizeMake(width, item.cellHeight)
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, atIndexPath indexPath:NSIndexPath) -> UICollectionReusableView
    {
        let header:UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(
            kind,
            withReuseIdentifier:
            VCreateHeader.reusableIdentifier(),
            forIndexPath:indexPath)
        
        return header
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let item:MCreateItem = modelAtIndex(indexPath)
        let cell:VCreateCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            item.reusableIdentifier,
            forIndexPath:
            indexPath) as! VCreateCell
        item.config(cell, controller:controller, indexPath:indexPath)
        
        return cell
    }
    
    func collectionView(collectionView:UICollectionView, shouldHighlightItemAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(collectionView:UICollectionView, shouldSelectItemAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        return false
    }
}