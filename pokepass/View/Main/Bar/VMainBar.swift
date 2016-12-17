import UIKit

class VMainBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controllerParent:CMainParent!
    weak var collection:UICollectionView!
    weak var back:VMainBarBack!
    weak var layoutCollectionLeft:NSLayoutConstraint!
    weak var layoutCollectionRight:NSLayoutConstraint!
    weak var layoutBackLeft:NSLayoutConstraint!
    weak var layoutBackRight:NSLayoutConstraint!
    fileprivate let model:MMainNav
    fileprivate var pos:MMainNavPos
    fileprivate let kButtonWidth:CGFloat = 70
    
    init(controllerParent:CMainParent)
    {
        model = MMainNav()
        pos = MMainNavPos.Normal()
        
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor.main()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controllerParent = controllerParent
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collection:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.isHidden = true
        collection.register(
            VMainBarCell.self,
            forCellWithReuseIdentifier:
            VMainBarCell.reusableIdentifier()
        )
        self.collection = collection
        
        let back:VMainBarBack = VMainBarBack(main:controllerParent)
        self.back = back
        
        addSubview(collection)
        addSubview(back)
        
        let views:[String:AnyObject] = [
            "collection":collection,
            "back":back]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[back]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutCollectionRight = NSLayoutConstraint(
            item:collection,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        layoutCollectionLeft = NSLayoutConstraint(
            item:collection,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        layoutBackRight = NSLayoutConstraint(
            item:back,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        layoutBackLeft = NSLayoutConstraint(
            item:back,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutCollectionRight)
        addConstraint(layoutCollectionLeft)
        addConstraint(layoutBackRight)
        addConstraint(layoutBackLeft)
        
        pos.adjust(self)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC))
        { [weak collection, weak model] in
            
            if model != nil
            {
                let indexPath:IndexPath = IndexPath(item:model!.current.index, section:0)
                collection?.selectItem(at: indexPath, animated:false, scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
                collection?.isHidden = false
            }
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        collection.collectionViewLayout.invalidateLayout()
        pos.adjust(self)
        
        DispatchQueue.main.async
        { [weak self] in
            
            if self != nil
            {
                let selected:Int = self!.model.current.index
                let selectedIndexPath:IndexPath = IndexPath(item:selected, section:0)
                self!.collection.scrollToItem(at: selectedIndexPath, at:UICollectionViewScrollPosition.centeredHorizontally, animated:true)
            }
        }
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    fileprivate func modelAtIndex(_ index:IndexPath) -> MMainNavItem
    {
        let item:MMainNavItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func pushed(_ name:String)
    {
        pos = MMainNavPos.Pushed()
        pos.adjust(self)
        back.label.text = name
    }
    
    func poped()
    {
        pos = MMainNavPos.Normal()
        pos.adjust(self)
    }
    
    //MARK: col del
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let margin:CGFloat = remain / 2.0
        let insets:UIEdgeInsets = UIEdgeInsetsMake(0, margin, 0, margin)
        
        return insets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width: kButtonWidth, height: height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:MMainNavItem = modelAtIndex(indexPath)
        let should:Bool = item.state.highlightable
        
        return should
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MMainNavItem = modelAtIndex(indexPath)
        let should:Bool = item.state.selectable
        
        return should
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MMainNavItem = modelAtIndex(indexPath)
        let cell:VMainBarCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VMainBarCell.reusableIdentifier(),
            for:
            indexPath) as! VMainBarCell
        item.config(cell)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MMainNavItem = modelAtIndex(indexPath)
        collectionView.scrollToItem(at: indexPath, at:UICollectionViewScrollPosition.centeredHorizontally, animated:true)
        let transition:MMainTransition = MMainTransition.transition(model.current.index, toIndex:item.index)
        let controller:UIViewController = item.controller()
        controllerParent.pushController(controller, transition:transition)
        model.selectItem(item)
    }
}
