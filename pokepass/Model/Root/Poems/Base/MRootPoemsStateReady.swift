import Foundation

class MRootPoemsStateReady:MRootPoemsState
{
    private let kTitle:String = "Ready"
    
    init()
    {
        let controllerType:CRootList.Type = CRootListReady.self
        let state:DInfraPoem.DInfraPoemStatus = DInfraPoem.DInfraPoemStatus.Ready
        super.init(controllerType:controllerType, state:state, title:kTitle)
    }
}