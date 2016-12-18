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
        backgroundColor = UIColor.complement
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let spinner:VMainLoader = VMainLoader()
        spinner.stopAnimating()
        self.spinner = spinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets.zero
        
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
            VProjectsDetailHeader.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VProjectsDetailHeader.reusableIdentifier)
        collection.register(
            VProjectsDetailFooter.self,
            forSupplementaryViewOfKind:
            UICollectionElementKindSectionFooter,
            withReuseIdentifier:
            VProjectsDetailFooter.reusableIdentifier)
        collection.register(
            VProjectsDetailCellSpeed.self,
            forCellWithReuseIdentifier:
            VProjectsDetailCellSpeed.reusableIdentifier)
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
        self.collection.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MProjectsDetailItem
    {
        let item:MProjectsDetailItem = controller.model.sections[index.section].items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func showLoading()
    {
        collection.isHidden = true
        spinner.startAnimating()
    }
    
    //MARK: col del
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let count:Int = controller.model.sections.count
        let size:CGSize
        
        if section == count - 1
        {
            size = CGSize(width:0, height:kFooterHeight)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MProjectsDetailItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width: width, height: item.cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.sections[section].items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            let header:VProjectsDetailHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier:
                VProjectsDetailHeader.reusableIdentifier,
                for:
                indexPath) as! VProjectsDetailHeader
            let headerModel:MProjectsDetailSection = controller.model.sections[indexPath.section]
            headerModel.config(header)
            
            reusable = header
        }
        else
        {
            let footer:VProjectsDetailFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier:
                VProjectsDetailFooter.reusableIdentifier,
                for:
                indexPath) as! VProjectsDetailFooter
            footer.config(controller)
            
            reusable = footer
        }
        
        return reusable
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MProjectsDetailItem = modelAtIndex(index:indexPath)
        let cell:VProjectsDetailCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: item.reusableIdentifier,
            for:
            indexPath) as! VProjectsDetailCell
        item.config(cell:cell, controller:controller)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MProjectsDetailItem = modelAtIndex(index:indexPath)
        let selectable:Bool = item.selectable
        
        return selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:MProjectsDetailItem = modelAtIndex(index:indexPath)
        let highlightable:Bool = item.selectable
        
        return highlightable
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MProjectsDetailItem = modelAtIndex(indexPath)
        item.selected(controller:controller)
    }
}
