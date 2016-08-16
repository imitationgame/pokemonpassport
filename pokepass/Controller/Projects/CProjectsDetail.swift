import UIKit

class CProjectsDetail:CMainController
{
    weak var viewDetail:VProjectsDetail!
    let model:MProjectsDetail
    let item:MProjectsItem
    private let kFileName:String = "%@.gpx"
    
    init(item:MProjectsItem)
    {
        model = MProjectsDetail()
        self.item = item
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewDetail:VProjectsDetail = VProjectsDetail(controller:self)
        self.viewDetail = viewDetail
        view = viewDetail
    }
    
    //MARK: private
    
    private func createGPX()
    {
        let maxDistance:Double = model.sectionSpeed.selectedItem.maxDistance
        item.getLocations(maxDistance)
        
        let gpxFile:String = item.print()
        let fileName:String = item.name.stringByReplacingOccurrencesOfString(" ", withString:"")
        let fullFileName:String = String(format:kFileName, fileName)
        let fileUrl:NSURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent(fullFileName)
        
        do
        {
            try gpxFile.writeToURL(fileUrl, atomically:true, encoding:NSUTF8StringEncoding)
        }
        catch
        {
        }
        
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            self?.sendFile(fileUrl)
        }
    }
    
    private func sendFile(file:NSURL)
    {
        let activity:UIActivityViewController = UIActivityViewController(activityItems:[file], applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = viewDetail
            activity.popoverPresentationController!.sourceRect = CGRectMake(0, 0, 1, 1)
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.Up
        }
        
        presentViewController(activity, animated:true)
        { [weak self] in
            
            self?.parent.backController()
        }
    }
    
    //MARK: public
    
    func share()
    {
        viewDetail.showLoading()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
        
            self?.createGPX()
        }
    }
}