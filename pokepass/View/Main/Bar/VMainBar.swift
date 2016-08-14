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
    private let model:MMainNav
    private var pos:MMainNavPos
    private let kButtonWidth:CGFloat = 70
    
    init(controllerParent:CMainParent)
    {
        model = MMainNav()
        pos = MMainNavPos.Normal()
        
        super.init(frame:CGRectZero)
        backgroundColor = UIColor.main()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controllerParent = controllerParent
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeZero
        flow.footerReferenceSize = CGSizeZero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let collection:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.clearColor()
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.scrollEnabled = false
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.hidden = true
        collection.registerClass(
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
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[back]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutCollectionRight = NSLayoutConstraint(
            item:collection,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        layoutCollectionLeft = NSLayoutConstraint(
            item:collection,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        layoutBackRight = NSLayoutConstraint(
            item:back,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        layoutBackLeft = NSLayoutConstraint(
            item:back,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutCollectionRight)
        addConstraint(layoutCollectionLeft)
        addConstraint(layoutBackRight)
        addConstraint(layoutBackLeft)
        
        pos.adjust(self)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue())
        { [weak collection, weak model] in
            
            if model != nil
            {
                let indexPath:NSIndexPath = NSIndexPath(forItem:model!.current.index, inSection:0)
                collection?.selectItemAtIndexPath(indexPath, animated:false, scrollPosition:UICollectionViewScrollPosition.CenteredHorizontally)
                collection?.hidden = false
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
        
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            if self != nil
            {
                let selected:Int = self!.model.current.index
                let selectedIndexPath:NSIndexPath = NSIndexPath(forItem:selected, inSection:0)
                self!.collection.scrollToItemAtIndexPath(selectedIndexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated:true)
            }
        }
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MMainNavItem
    {
        let item:MMainNavItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func pushed(name:String)
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
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAtIndex section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let margin:CGFloat = remain / 2.0
        let insets:UIEdgeInsets = UIEdgeInsetsMake(0, margin, 0, margin)
        
        return insets
    }
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSizeMake(kButtonWidth, height)
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, shouldHighlightItemAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        let item:MMainNavItem = modelAtIndex(indexPath)
        let should:Bool = item.state.highlightable
        
        return should
    }
    
    func collectionView(collectionView:UICollectionView, shouldSelectItemAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        let item:MMainNavItem = modelAtIndex(indexPath)
        let should:Bool = item.state.selectable
        
        return should
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let item:MMainNavItem = modelAtIndex(indexPath)
        let cell:VMainBarCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            VMainBarCell.reusableIdentifier(),
            forIndexPath:
            indexPath) as! VMainBarCell
        item.config(cell)
        
        return cell
    }
    
    func collectionView(collectionView:UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let item:MMainNavItem = modelAtIndex(indexPath)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated:true)
        let transition:MMainTransition = MMainTransition.transition(model.current.index, toIndex:item.index)
        let controller:UIViewController = item.controller()
        controllerParent.pushController(controller, transition:transition)
        model.selectItem(item)
    }
}