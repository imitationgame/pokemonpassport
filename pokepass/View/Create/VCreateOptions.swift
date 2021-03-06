import UIKit

class VCreateOptions:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CCreate!
    weak var collection:UICollectionView!
    let model:MCreateOptions
    private let kDeselectTime:TimeInterval = 0.3
    private let kCollectionWidth:CGFloat = 150
    
    init(controller:CCreate)
    {
        model = MCreateOptions()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.main
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.sectionInset = UIEdgeInsets.zero
        
        let collection:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            VCreateOptionsCell.self,
            forCellWithReuseIdentifier:
            VCreateOptionsCell.reusableIdentifier)
        self.collection = collection
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(named:"genericBack"),
            for:UIControlState())
        button.imageView?.contentMode = UIViewContentMode.center
        button.imageView?.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsetsMake(
            20, 0, 0, 25)
        button.addTarget(
            self,
            action:#selector(self.actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(collection)
        addSubview(button)
        
        let views:[String:UIView] = [
            "collection":collection,
            "button":button]
        
        let metrics:[String:CGFloat] = [
            "collectionWidth":kCollectionWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[button(65)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[collection(collectionWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        self.collection.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCreateOptionsItem
    {
        let item:MCreateOptionsItem = model.items[index.item]
        
        return item
    }
    
    //MARK: col del

    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let count:CGFloat = CGFloat(model.items.count)
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let widthPerCell:CGFloat = width / count
        let size:CGSize = CGSize(width:widthPerCell, height:height)
        
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
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCreateOptionsItem = modelAtIndex(index:indexPath)
        let cell:VCreateOptionsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCreateOptionsCell.reusableIdentifier,
            for:indexPath) as! VCreateOptionsCell
        item.config(cell:cell)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MCreateOptionsItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
