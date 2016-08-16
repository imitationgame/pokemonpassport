import UIKit

class VProjects:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CProjects!
    weak var spinner:VMainLoader!
    weak var collection:UICollectionView!
    private let kCollectionBottom:CGFloat = 40
    private let kHeaderHeight:CGFloat = 100
    private let kCellHeight:CGFloat = 60
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CProjects)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.complement()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let spinner:VMainLoader = VMainLoader()
        self.spinner = spinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.footerReferenceSize = CGSizeZero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.Vertical
        flow.sectionInset = UIEdgeInsetsMake(0, 0, kCollectionBottom, 0)
        
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
            VProjectsHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VProjectsHeader.reusableIdentifier())
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
    
    private func modelAtIndex(index:NSIndexPath) -> MProjectsItem
    {
        let item:MProjectsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func modelLoaded()
    {
        spinner.stopAnimating()
        collection.reloadData()
        collection.hidden = false
    }
    
    //MARK: col del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let size:CGSize
        
        if controller.model.items.isEmpty
        {
            let width:CGFloat = collectionView.bounds.maxX
            size = CGSizeMake(width, kHeaderHeight)
        }
        else
        {
            size = CGSizeZero
        }
        
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
        let count:Int = controller.model.items.count
        
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
        let item:MProjectsItem = modelAtIndex(indexPath)
        let cell:VProjectsCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            VProjectsCell.reusableIdentifier(),
            forIndexPath:
            indexPath) as! VProjectsCell
        cell.config(item)
        
        return cell
    }
    
    func collectionView(collectionView:UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let item:MProjectsItem = modelAtIndex(indexPath)
        let transition:MMainTransition = MMainTransition.Push(item.name)
        let detail:CProjectsDetail = CProjectsDetail(item:item)
        controller.parent.pushController(detail, transition:transition)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue())
        { [weak collectionView] in
            
            collectionView?.selectItemAtIndexPath(nil, animated:false, scrollPosition:UICollectionViewScrollPosition.None)
        }
    }
}