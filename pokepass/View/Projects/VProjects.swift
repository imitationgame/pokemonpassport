import UIKit

class VProjects:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CProjects!
    weak var spinner:VMainLoader!
    weak var collection:UICollectionView!
    private let kCollectionBottom:CGFloat = 40
    private let kHeaderHeight:CGFloat = 130
    private let kCellHeight:CGFloat = 70
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CProjects)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.complement
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let spinner:VMainLoader = VMainLoader()
        self.spinner = spinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
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
            VProjectsHeader.reusableIdentifier)
        collection.register(
            VProjectsCell.self,
            forCellWithReuseIdentifier:
            VProjectsCell.reusableIdentifier)
        collection.isHidden = true
        self.collection = collection
        
        addSubview(spinner)
        addSubview(collection)
        
        let views:[String:UIView] = [
            "spinner":spinner,
            "collection":collection]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func layoutSubviews()
    {
        collection.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MProjectsItem
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
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
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
        let reusable:VProjectsHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VProjectsHeader.reusableIdentifier,
            for:indexPath) as! VProjectsHeader
        reusable.config(controller:controller)
        
        return reusable
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MProjectsItem = modelAtIndex(index:indexPath)
        let cell:VProjectsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VProjectsCell.reusableIdentifier,
            for:
            indexPath) as! VProjectsCell
        cell.config(model:item, controller:controller)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
