import UIKit

class CProjects:CMainController
{
    weak var viewProjects:VProjects!
    let model:MProjects
    
    init()
    {
        model = MProjects()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadProjects()
    }
    
    override func loadView()
    {
        let viewProjects:VProjects = VProjects(controller:self)
        self.viewProjects = viewProjects
        view = viewProjects
    }
    
    //MARK: private
    
    private func loadProjects()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let sorter:NSSortDescriptor = NSSortDescriptor(key:"name", ascending:true, selector:#selector(NSString.caseInsensitiveCompare))
            let sorters:[NSSortDescriptor] = [sorter]
            DManager.sharedInstance.fetchManagedObjects(
                modelType:DObjectProject.self,
                sorters:sorters)
            { [weak self] (modelProjects:[DObjectProject]?) in
                
                var projects:[MProjectsItem] = []
                
                if let objectProjects:[DObjectProject] = modelProjects
                {
                    for project:DObjectProject in objectProjects
                    {
                        let item:MProjectsItem = MProjectsItem(model:project)
                        projects.append(item)
                    }
                }
                
                self?.model.items = projects
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.viewProjects.modelLoaded()
                }
            }
        }
    }
    
    //MARK: public
    
    func createProject()
    {
        let controller:CCreate = CCreate()
        let transition:MMainTransition = MMainTransitionPush(pushed:controller.na)
        parentController.pushController(controller:controller, transition:transition)
    }
}
