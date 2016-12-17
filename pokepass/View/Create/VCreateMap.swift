import UIKit
import MapKit

class VCreateMap:MKMapView, MKMapViewDelegate
{
    weak var controller:CCreate!
    let span:MKCoordinateSpan
    var polyLine:MKPolyline?
    fileprivate var userCoordinate:CLLocationCoordinate2D!
    fileprivate let kSpanSize:CLLocationDegrees = 0.01
    fileprivate let kPolylineWidth:CGFloat = 6
    
    init(controller:CCreate)
    {
        span = MKCoordinateSpan(latitudeDelta:kSpanSize, longitudeDelta:kSpanSize)
        
        super.init(frame:CGRect.zero)
        self.controller = controller
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isRotateEnabled = false
        isScrollEnabled = true
        isZoomEnabled = true
        isPitchEnabled = false
        mapType = MKMapType.standard
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
        let point:CGPoint = CGPoint(x: centerX, y: centerY)
        let location:CLLocationCoordinate2D = convert(point, toCoordinateFrom:self)
        
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
            remove(polyLine!)
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
            add(polyLine!, level:MKOverlayLevel.aboveRoads)
        }
    }
    
    func centerLocation(_ locationCoordinate:CLLocationCoordinate2D)
    {
        let region:MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        setRegion(region, animated:true)
    }
    
    func searchLocation(_ query:String)
    {
        let searchRequest:MKLocalSearchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = query
        
        let localSearch:MKLocalSearch = MKLocalSearch(request:searchRequest)
        localSearch.start
        { (response, error) in
            
            if error == nil && response != nil
            {
                if !response!.mapItems.isEmpty
                {
                    let firstLocation:MKMapItem = response!.mapItems.first!
                    let location:CLLocationCoordinate2D = firstLocation.placemark.coordinate
                    
                    DispatchQueue.main.async
                    { [weak self] in
                        
                        self?.centerLocation(location)
                    }
                }
            }
        }
    }
    
    //MARK: map delegate
    
    func mapView(_ mapView:MKMapView, rendererFor overlay:MKOverlay) -> MKOverlayRenderer
    {
        let polyline:MKPolyline = overlay as! MKPolyline
        let renderer:MKPolylineRenderer = MKPolylineRenderer(polyline:polyline)
        renderer.lineWidth = kPolylineWidth
        renderer.strokeColor = UIColor.main()
        
        return renderer
    }
    
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView?
    {
        let modelAnnotation:MCreateAnnotation = annotation as! MCreateAnnotation
        let reusableIdentifier:String = modelAnnotation.reusableIdentifier
        var view:MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: reusableIdentifier)
        
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
    
    func mapView(_ mapView:MKMapView, didSelect view:MKAnnotationView)
    {
        controller.viewCreate.showingCallout()
    }
    
    func mapView(_ mapView:MKMapView, didDeselect view:MKAnnotationView)
    {
        controller.viewCreate.notShowingCallout()
    }
    
    func mapView(_ mapView:MKMapView, annotationView view:MKAnnotationView, calloutAccessoryControlTapped control:UIControl)
    {
        mapView.deselectAnnotation(view.annotation, animated:true)
        
        let tag:Int = control.tag
        let callOut:VCreateMapPin.VCreateMapPinCallout = VCreateMapPin.VCreateMapPinCallout(rawValue:tag)!
        let annotation:MCreateAnnotation = view.annotation as! MCreateAnnotation
        
        switch callOut
        {
            case VCreateMapPin.VCreateMapPinCallout.delete:
                
                controller.removeLocation(annotation)
                
                break
                
            case VCreateMapPin.VCreateMapPinCallout.move:
                
                controller.moveLocation(annotation)
                
                break
        }
    }
}
