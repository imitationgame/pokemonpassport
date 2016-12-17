import UIKit

class VProjects:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CProjects!
    weak var spinner:VMainLoader!
    weak var collection:UICollectionView!
    fileprivate let kCollectionBottom:CGFloat = 40
    fileprivate let kHeaderHeight:CGFloat = 100
    fileprivate let kCellHeight:CGFloat = 60
    fileprivate let kInterLine:CGFloat = 1
    
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
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsetsMake(0, 0, kCollectionBottom, 0)
        
        let collection:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            VProjectsHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VProjectsHeader.reusableIdentifier())
        collection.register(
            VProjectsCell.self,
            forCellWithReuseIdentifier:
            VProjectsCell.reusableIdentifier())
        collection.isHidden = true
        self.collection = collection
        
        addSubview(spinner)
        addSubview(collection)
        
        let views:[String:AnyObject] = [
            "spinner":spinner,
            "collection":collection]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[collection]-0-|",
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
    
    fileprivate func modelAtIndex(_ index:IndexPath) -> MProjectsItem
    {
        let item:MProjectsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func modelLoaded()
    {
        spinner.stopAnimating()
        collection.reloadData()
        collection.isHidden = false
    }
    
    //MARK: col del
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let size:CGSize
        
        if controller.model.items.isEmpty
        {
            let width:CGFloat = collectionView.bounds.maxX
            size = CGSize(width: width, height: kHeaderHeight)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width: width, height: kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier:
            VProjectsHeader.reusableIdentifier(),
            for:
            indexPath)
        
        return reusable
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MProjectsItem = modelAtIndex(indexPath)
        let cell:VProjectsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VProjectsCell.reusableIdentifier(),
            for:
            indexPath) as! VProjectsCell
        cell.config(item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MProjectsItem = modelAtIndex(indexPath)
        let transition:MMainTransition = MMainTransition.Push(item.name)
        let detail:CProjectsDetail = CProjectsDetail(item:item)
        controller.parent.pushController(detail, transition:transition)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC))
        { [weak collectionView] in
            
            collectionView?.selectItem(at: nil, animated:false, scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
