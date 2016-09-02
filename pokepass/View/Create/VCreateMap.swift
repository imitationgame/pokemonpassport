import UIKit
import MapKit

class VCreateMap:MKMapView, MKMapViewDelegate
{
    weak var controller:CCreate!
    let span:MKCoordinateSpan
    var polyLine:MKPolyline?
    private var userCoordinate:CLLocationCoordinate2D!
    private let kSpanSize:CLLocationDegrees = 0.01
    private let kPolylineWidth:CGFloat = 6
    
    init(controller:CCreate)
    {
        span = MKCoordinateSpan(latitudeDelta:kSpanSize, longitudeDelta:kSpanSize)
        
        super.init(frame:CGRectZero)
        self.controller = controller
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        rotateEnabled = false
        scrollEnabled = true
        zoomEnabled = true
        pitchEnabled = false
        mapType = MKMapType.Standard
        showsBuildings = true
        showsPointsOfInterest = true
        showsCompass = true
        showsScale = true
        showsTraffic = false
        delegate = self
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func coordinatesAtCenter() -> CLLocationCoordinate2D
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let centerX:CGFloat = width / 2
        let centerY:CGFloat = height / 2
        let point:CGPoint = CGPointMake(centerX, centerY)
        let location:CLLocationCoordinate2D = convertPoint(point, toCoordinateFromView:self)
        
        return location
    }
    
    func annotationAtCenter() -> MCreateAnnotation
    {
        let location:CLLocationCoordinate2D = coordinatesAtCenter()
        let annotation:MCreateAnnotation = MCreateAnnotation(coordinate:location)
        
        return annotation
    }
    
    func clearRoute()
    {
        if polyLine != nil
        {
            removeOverlay(polyLine!)
        }
    }
    
    func regenerateRoute()
    {
        clearRoute()
        
        let count:Int = controller.model.locations.count
        
        if count > 0
        {
            var coordinates:[CLLocationCoordinate2D] = []
            
            for item:MCreateAnnotation in controller.model.locations
            {
                coordinates.append(item.coordinate)
            }
            
            polyLine = MKPolyline(coordinates:&coordinates, count:count)
            addOverlay(polyLine!, level:MKOverlayLevel.AboveRoads)
        }
    }
    
    func centerLocation(locationCoordinate:CLLocationCoordinate2D)
    {
        let region:MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        setRegion(region, animated:true)
    }
    
    func searchLocation(query:String)
    {
        let searchRequest:MKLocalSearchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = query
        
        let localSearch:MKLocalSearch = MKLocalSearch(request:searchRequest)
        localSearch.startWithCompletionHandler
        { (response, error) in
            
            if error == nil && response != nil
            {
                if !response!.mapItems.isEmpty
                {
                    let firstLocation:MKMapItem = response!.mapItems.first!
                    let location:CLLocationCoordinate2D = firstLocation.placemark.coordinate
                    
                    dispatch_async(dispatch_get_main_queue())
                    { [weak self] in
                        
                        self?.centerLocation(location)
                    }
                }
            }
        }
    }
    
    //MARK: map delegate
    
    func mapView(mapView:MKMapView, rendererForOverlay overlay:MKOverlay) -> MKOverlayRenderer
    {
        let polyline:MKPolyline = overlay as! MKPolyline
        let renderer:MKPolylineRenderer = MKPolylineRenderer(polyline:polyline)
        renderer.lineWidth = kPolylineWidth
        renderer.strokeColor = UIColor.main()
        
        return renderer
    }
    
    func mapView(mapView:MKMapView, viewForAnnotation annotation:MKAnnotation) -> MKAnnotationView?
    {
        let modelAnnotation:MCreateAnnotation = annotation as! MCreateAnnotation
        let reusableIdentifier:String = modelAnnotation.reusableIdentifier
        var view:MKAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(reusableIdentifier)
        
        if view == nil
        {
            view = modelAnnotation.view()
        }
        else
        {
            view!.annotation = modelAnnotation
        }
        
        return view
    }
    
    func mapView(mapView:MKMapView, didSelectAnnotationView view:MKAnnotationView)
    {
        controller.viewCreate.showingCallout()
    }
    
    func mapView(mapView:MKMapView, didDeselectAnnotationView view:MKAnnotationView)
    {
        controller.viewCreate.notShowingCallout()
    }
    
    func mapView(mapView:MKMapView, annotationView view:MKAnnotationView, calloutAccessoryControlTapped control:UIControl)
    {
        mapView.deselectAnnotation(view.annotation, animated:true)
        
        let tag:Int = control.tag
        let callOut:VCreateMapPin.VCreateMapPinCallout = VCreateMapPin.VCreateMapPinCallout(rawValue:tag)!
        let annotation:MCreateAnnotation = view.annotation as! MCreateAnnotation
        
        switch callOut
        {
            case VCreateMapPin.VCreateMapPinCallout.Delete:
                
                controller.removeLocation(annotation)
                
                break
                
            case VCreateMapPin.VCreateMapPinCallout.Move:
                
                controller.moveLocation(annotation)
                
                break
        }
    }
}