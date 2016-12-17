import UIKit

class MSettingsMenuItemMetrics:MSettingsMenuItem
{
    weak var cellMetrics:VSettingsCellMetrics!
    let options:[MSettingsMenuItemMetricsOption]
    fileprivate let kCellHeight:CGFloat = 80
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellMetrics.reusableIdentifier()
        let optionInternational:MSettingsMenuItemMetricsOptionInternational = MSettingsMenuItemMetricsOption.International()
        let optionUs:MSettingsMenuItemMetricsOptionUs = MSettingsMenuItemMetricsOption.Us()
        
        options = [
            optionInternational,
            optionUs
        ]
        
        super.init(reusableIdentifier:reusableIdentifier, cellHeight:kCellHeight)
    }
    
    override func config(_ cell:VSettingsCell, controller:CSettings)
    {
        let countOptions:Int = options.count
        cellMetrics = cell as! VSettingsCellMetrics
        cellMetrics.segmented.removeAllSegments()
        cellMetrics.segmented.addTarget(self, action:#selector(self.actionSegmented(sender:)), for:UIControlEvents.valueChanged)
        
        for index:Int in 0 ..< countOptions
        {
            let option:MSettingsMenuItemMetricsOption = options[index]
            let optionName:String = option.name
            cellMetrics.segmented.insertSegment(withTitle: optionName, at:index, animated:false)
        }
        
        showSelected()
    }
    
    @objc func actionSegmented(sender segmented:UISegmentedControl)
    {
        let selected:Int = segmented.selectedSegmentIndex
        let optionSelected:MSettingsMenuItemMetricsOption = options[selected]
        MSettings.sharedInstance.model!.measures = optionSelected.measure
        DManager.sharedInstance.managerPokePass.saver.save(false)
    }
    
    //MARK: private
    
    fileprivate func showSelected()
    {
        let measures:DPokePassSettings.DPokePassSettingsMeasure = MSettings.sharedInstance.model!.measures
        let countOptions:Int = options.count
        
        for index:Int in 0 ..< countOptions
        {
            let option:MSettingsMenuItemMetricsOption = options[index]
            
            if option.measure == measures
            {
                cellMetrics.segmented.selectedSegmentIndex = index
                
                break
            }
        }
    }
}
