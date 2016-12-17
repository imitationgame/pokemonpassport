import UIKit

class CProjectsDetail:CMainController
{
    weak var viewDetail:VProjectsDetail!
    let model:MProjectsDetail
    let item:MProjectsItem
    fileprivate let kFileName:String = "%@.gpx"
    
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
        let fileName:String = item.name.replacingOccurrences(of:" ", with:"")
        let fullFileName:String = String(format:kFileName, fileName)
        let fileUrl:URL = URL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent(fullFileName)
        
        do
        {
            try gpxFile.write(to:fileUrl, atomically:true, encoding:String.Encoding.utf8)
        }
        catch
        {
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.sendFile(fileUrl)
        }
    }
    
    private func sendFile(file:URL)
    {
        let activity:UIActivityViewController = UIActivityViewController(activityItems:[file], applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = viewDetail
            activity.popoverPresentationController!.sourceRect = CGRect(x:0, y:0, width:1, height:1)
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
        { [weak self] in
            
            self?.parentController.backController()
        }
    }
    
    //MARK: public
    
    func share()
    {
        viewDetail.showLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
        
            self?.createGPX()
        }
    }
}
