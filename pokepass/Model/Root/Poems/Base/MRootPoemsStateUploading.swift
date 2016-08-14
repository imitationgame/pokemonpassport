import Foundation

class MRootPoemsStateUploading:MRootPoemsState
{
    private let kTitle:String = "Uploading"
    
    init()
    {
        let controllerType:CRootList.Type = CRootListUploading.self
        let state:DInfraPoem.DInfraPoemStatus = DInfraPoem.DInfraPoemStatus.Uploading
        super.init(controllerType:controllerType, state:state, title:kTitle)
    }
}