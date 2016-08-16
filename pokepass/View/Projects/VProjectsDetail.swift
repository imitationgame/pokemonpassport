import UIKit

class VProjectsDetail:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CProjectsDetail!
    weak var spinner:VMainLoader!
    weak var collection:UICollectionView!
    private let kFooterHeight:CGFloat = 150
    private let kHeaderHeight:CGFloat = 60
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CProjectsDetail)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.complement()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let spinner:VMainLoader = VMainLoader()
        spinner.stopAnimating()
        self.spinner = spinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeMake(0, kHeaderHeight)
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
            VProjectsDetailCellSpeed.self,
            forCellWithReuseIdentifier:
            VProjectsDetailCellSpeed.reusableIdentifier())
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
    
    //MARK: public
    
    func showLoading()
    {
        collection.hidden = true
        spinner.startAnimating()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MProjectsDetailItem
    {
        let item:MProjectsDetailItem = controller.model.sections[index.section].items[index.item]
        
        return item
    }
    
    //MARK: col del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let count:Int = controller.model.sections.count
        let size:CGSize
        
        if section == count - 1
        {
            size = CGSizeMake(0, kFooterHeight)
        }
        else
        {
            size = CGSizeZero
        }
        
        return size
    }
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let item:MProjectsDetailItem = modelAtIndex(indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSizeMake(width, item.cellHeight)
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.sections[section].items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, atIndexPath indexPath:NSIndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            let header:VProjectsDetailHeader = collectionView.dequeueReusableSupplementaryViewOfKind(
                kind,
                withReuseIdentifier:
                VProjectsDetailHeader.reusableIdentifier(),
                forIndexPath:
                indexPath) as! VProjectsDetailHeader
            let headerModel:MProjectsDetailSection = controller.model.sections[indexPath.section]
            headerModel.config(header)
            
            reusable = header
        }
        else
        {
            let footer:VProjectsDetailFooter = collectionView.dequeueReusableSupplementaryViewOfKind(
                kind,
                withReuseIdentifier:
                VProjectsDetailFooter.reusableIdentifier(),
                forIndexPath:
                indexPath) as! VProjectsDetailFooter
            footer.config(controller)
            
            reusable = footer
        }
        
        return reusable
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let item:MProjectsDetailItem = modelAtIndex(indexPath)
        let cell:VProjectsDetailCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            item.reusableIdentifier,
            forIndexPath:
            indexPath) as! VProjectsDetailCell
        item.config(cell, controller:controller)
        
        return cell
    }
    
    func collectionView(collectionView:UICollectionView, shouldSelectItemAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        let item:MProjectsDetailItem = modelAtIndex(indexPath)
        let selectable:Bool = item.selectable
        
        return selectable
    }
    
    func collectionView(collectionView:UICollectionView, shouldHighlightItemAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        let item:MProjectsDetailItem = modelAtIndex(indexPath)
        let highlightable:Bool = item.selectable
        
        return highlightable
    }
    
    func collectionView(collectionView:UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let item:MProjectsDetailItem = modelAtIndex(indexPath)
        item.selected(controller)
    }
}