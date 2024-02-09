//
//  ViewController.swift
//  mapView
//
//  Created by Assemgul on 19.12.2023.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {

    @IBOutlet weak var labelHotel: UILabel!
    
    
    @IBOutlet weak var labelAddress: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var hotel = Hotels()
    
    var userLocation = CLLocation(latitude: 37.58159, longitude: -122.12547)
    
    var followMe = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mapView.delegate = self
        labelHotel.text = hotel.hotel
        labelAddress.text = hotel.address
        imageView.image = UIImage(named: hotel.imageName)
        
        // ______________ Метка на карте ______________
        // Создаем координта передавая долготу и широту
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(hotel.lat, hotel.long)
        
        // Создаем метку на карте
        let anotation = MKPointAnnotation()
        
        // Задаем коортинаты метке
        anotation.coordinate = location
        // Задаем название метке
        anotation.title = hotel.hotel
        // Задаем описание метке
        anotation.subtitle = hotel.address
        
        // Добавляем метку на карту
        self.mapView.addAnnotation(anotation)
        // ______________ Метка на карте ______________
        
        
        
        let latDelta:CLLocationDegrees = 0.7
        let longDelta:CLLocationDegrees = 0.7
        
        // Создаем область шириной и высотой по дельте
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        // Создаем регион на карте с моими координатоми в центре
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        
        // Приближаем карту с анимацией в данный регион
        self.mapView.setRegion(region, animated: true)
        
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            self.mapView.removeOverlay(mapView.overlays as! MKOverlay)
            // Получаем координаты метки
            let ulocation: CLLocation = CLLocation(latitude: (hotel.lat), longitude: (hotel.long))
            
            // Считаем растояние до метки от нашего пользователя
            let _:CLLocationDistance = ulocation.distance(from: userLocation)
            
            // Routing - построение маршрута
            // 1 Координаты начальной точки А и точки B
            let sourceLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
            let destinationLocation = CLLocationCoordinate2D(latitude: hotel.lat, longitude: hotel.long)
            
            // 2 упаковка в Placemark
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            
            // 3 упаковка в MapItem
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            // 4 Запрос на построение маршрута
            let directionRequest = MKDirections.Request()
            // указываем точку А, то есть нашего пользователя
            directionRequest.source = sourceMapItem
            // указываем точку B, то есть метку на карте
            directionRequest.destination = destinationMapItem
            // выбираем на чем будем ехать - на машине
            directionRequest.transportType = .automobile
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            // 5 Запускаем просчет маршрута
            directions.calculate {
                (response, error) -> Void in
                
                // Если будет ошибка с маршрутом
                guard let response = response else { return }
                
                for route in response.routes {
                    self.mapView.addOverlay(route.polyline)
                }
                
                // Берем первый машрут
                //            let route = response.routes[0]
                //            // Рисуем на карте линию маршрута (polyline)
                //            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
                //
                //            // Приближаем карту с анимацией в регион всего маршрута
                //            let rect = route.polyline.boundingMapRect
                //            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }
    
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        
//        print(view.annotation?.title as Any)
//        
//        // Получаем координаты метки
//        let location:CLLocation = CLLocation(latitude: (view.annotation?.coordinate.latitude)!, longitude: (view.annotation?.coordinate.longitude)!)
//        
//        // Считаем растояние до метки от нашего пользователя
//        let meters:CLLocationDistance = location.distance(from: userLocation)
//        //distanceLabel.text = String(format: "Distance: %.2f m", meters)
//        
//        
//        // Routing - построение маршрута
//        // 1 Координаты начальной точки А и точки B
//        let sourceLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//        
//        let destinationLocation = CLLocationCoordinate2D(latitude: (view.annotation?.coordinate.latitude)!, longitude: (view.annotation?.coordinate.longitude)!)
//        
//        // 2 упаковка в Placemark
//        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
//        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
//        
//        // 3 упаковка в MapItem
//        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
//        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
//        
//        // 4 Запрос на построение маршрута
//        let directionRequest = MKDirections.Request()
//        // указываем точку А, то есть нашего пользователя
//        directionRequest.source = sourceMapItem
//        // указываем точку B, то есть метку на карте
//        directionRequest.destination = destinationMapItem
//        // выбираем на чем будем ехать - на машине
//        directionRequest.transportType = .automobile
//        
//        // Calculate the direction
//        let directions = MKDirections(request: directionRequest)
//        
//        // 5 Запускаем просчет маршрута
//        directions.calculate {
//            (response, error) -> Void in
//            
//            // Если будет ошибка с маршрутом
//            guard let response = response else {
//                if let error = error {
//                    print("Error: \(error)")
//                }
//                
//                return
//            }
//            
            // Берем первый машрут
//            let route = response.routes[0]
//            // Рисуем на карте линию маршрута (polyline)
//            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
//            
//            // Приближаем карту с анимацией в регион всего маршрута
//            let rect = route.polyline.boundingMapRect
//            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
//        }
//        
//    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // Настраиваем линию
        let renderer = MKPolylineRenderer(overlay: overlay)
        // Цвет красный
        renderer.strokeColor = UIColor.green
        // Ширина линии
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
}

