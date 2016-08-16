import UIKit

class VProjectsDetail:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CProjectsDetail!
    weak var spinner:VMainLoader!
    weak var collection:UICollectionView!
    private let kFooterHeight:CGFloat = 100
    private let kHeaderHeight:CGFloat = 50
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CProjectsDetail)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.complement()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let spinner:VMainLoader = VMainLoader()
        self.spinner = spinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeZero
        flow.footerReferenceSize = CGSizeZero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.Vertical
        flow.sectionInset = UIEdgeInsetsZero
        
        let collection:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.backgroundColor = UIColor.clearColor()
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.dataSource = self
        collection.delegate = self
        collection.registerClass(
            VProjectsDetailHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VProjectsDetailHeader.reusableIdentifier())
        collection.registerClass(
            VProjectsDetailFooter.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionFooter,
            withReuseIdentifier:
            VProjectsDetailFooter.reusableIdentifier())
        collection.registerClass(
            VProjectsCell.self,
            forCellWithReuseIdentifier:
            VProjectsCell.reusableIdentifier())
        collection.hidden = true
        self.collection = collection
        
        addSubview(spinner)
        addSubview(collection)
        
        let views:[String:AnyObject] = [
            "spinner":spinner,
            "collection":collection]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
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
    
    override func layoutSubviews()
    {
        self.collection.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    
    //MARK: public
    
    func modelLoaded()
    {
        spinner.stopAnimating()
        collection.reloadData()
        collection.hidden = false
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MProjectsDetailItem
    {
        let item:MProjectsDetailItem = controller.model.sections[index.section].items[index.item]
        
        return item
    }
    
    //MARK: col del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let size:CGSize = CGSizeZero
        
        return size
    }
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSizeMake(width, kCellHeight)
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = 0
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, atIndexPath indexPath:NSIndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(
            kind,
            withReuseIdentifier:
            VProjectsHeader.reusableIdentifier(),
            forIndexPath:
            indexPath)
        
        return reusable
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let cell:VProjectsCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            VProjectsCell.reusableIdentifier(),
            forIndexPath:
            indexPath) as! VProjectsCell
        
        return cell
    }
    
    func collectionView(collectionView:UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
    }
}