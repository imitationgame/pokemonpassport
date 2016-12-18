import UIKit

class VCreateHistory:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var collectionView:UICollectionView!
    private weak var controller:CCreate!
    private let kInterline:CGFloat = 1
    private let kCellWidth:CGFloat = 115
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor(white:0.95, alpha:1)
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.minimumLineSpacing = kInterline
        flow.minimumInteritemSpacing = kInterline
        flow.sectionInset = UIEdgeInsets(
            top:kInterline,
            left:kInterline,
            bottom:kInterline,
            right:kInterline)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VCreateHistoryCell.self,
            forCellWithReuseIdentifier:
            VCreateHistoryCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCreateAnnotation
    {
        let item:MCreateAnnotation = controller.model.locations[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
        
        let count:Int = controller.model.locations.count
        let last:Int = count - 1
        
        if last >= 0
        {
            let index:IndexPath = IndexPath(item:last, section:0)
            collectionView.selectItem(
                at:index,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
        }
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let usableHeight:CGFloat = height - (kInterline + kInterline)
        let size:CGSize = CGSize(width:kCellWidth, height:usableHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let count:Int = controller.model.locations.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let itemPrevious:MCreateAnnotation?
        let index:Int = indexPath.item
        let indexPrev:Int = index - 1
        let indexNext:Int = index + 1
        
        if index > 0
        {
            let indexPathPrev:IndexPath = IndexPath(
                item:indexPrev,
                section:0)
            
            itemPrevious = modelAtIndex(index:indexPathPrev)
        }
        else
        {
            itemPrevious = nil
        }
        
        let item:MCreateAnnotation = modelAtIndex(index:indexPath)
        let cell:VCreateHistoryCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCreateHistoryCell.reusableIdentifier,
            for:indexPath) as! VCreateHistoryCell
        cell.config(
            index:indexNext,
            model:item,
            modelPrevious:itemPrevious)
        
        return cell
    }
}
