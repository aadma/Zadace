//: Playground - noun: a place where people can play

//import UIKit

import Foundation

func delayedPrint(str: String){

    sleep(2)
    print(str)
}

protocol DrivingLicence{
    var licences: Set<DrivingLicenceType> {get set}
}

protocol CarMonitoringDelegate{
    func engineBroke()
    func lowOnFuel()
    func outOfFuel()
}

class Person{
    var firstName: String
    var lastName: String
    var age: Int
    init(firstName: String, lastName: String, age: Int){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

class Driver: Person, DrivingLicence{
    var licences: Set<DrivingLicenceType>
    weak var mechanic: Mechanic?
    weak var car: Car?
    init(firstName: String, lastName: String, age: Int, licences: Set<DrivingLicenceType>){
        self.licences = licences
        super.init(firstName: firstName, lastName: lastName, age: age)
    }
    func callMechanic(mechanic: Mechanic, toFixACar car: Car){
        if mechanic.authorizedServicerForLicenceTypes.contains(car.licenceType){
            print("Mechanic responded he can fix this car")
            mechanic.fixCar(car)
        }
    }
    func driveCar(){
        car!.drive()
    }
}

class Mechanic: Person{
    var authorizedServicerForLicenceTypes: Set<DrivingLicenceType>
    init(firstName: String, lastName: String, age: Int, authorizedServicerForLicenceTypes: Set<DrivingLicenceType>){
        self.authorizedServicerForLicenceTypes = authorizedServicerForLicenceTypes
        super.init(firstName: firstName, lastName: lastName, age: age)
    }
    func fixCar(car: Car){
        print("\(super.firstName) is fixing the car")
        car.broken = false
        print("Car fixed")
    }
}

class Car{
    var name: String
    var model: String
    var licenceType: DrivingLicenceType
    var fuelTank: Int
    var crossedKilometers = 0
    private var fuel: Int?
    var fuelLevel: Int{
        get{
            return fuel!
        }
        set(newValue){
            if newValue > fuelTank{
                fuel = fuelTank
            }else{
                fuel = newValue
            }
        }
    }
    var broken = false
    var engineOn = false
    var driver: DrivingLicence?
    var delegate: CarMonitoringDelegate?
    init(name: String, model: String, licenceType: DrivingLicenceType, fuelTank: Int, fuelLevel: Int){
        self.name = name
        self.model = model
        self.licenceType = licenceType
        self.fuelTank = fuelTank
        
        self.fuelLevel = fuelLevel
    }
    func stop(){
        engineOn = false
    }
    func drive(){
        print("Starting engine")
        engineOn = true
        while engineOn == true{
            if broken == true{
                print("Engine broke")
                delegate?.engineBroke()
                stop()
            }
            if fuelLevel == 10{
                print("Low on fuel")
                delegate?.lowOnFuel()
            }
            guard fuelLevel > 0 else{
                print("Empty fuel tank")
                delegate?.outOfFuel()
                break
            }
            fuelLevel -= 1
            crossedKilometers += 10
            if arc4random_uniform(100)+1 == 1{broken = true}
        }
    }
}

extension Driver: CarMonitoringDelegate{
    func engineBroke() {
        print("Engine broke")
        callMechanic(mechanic!, toFixACar: car!)
    }
    func lowOnFuel() {
        if arc4random_uniform(3)+1 == 1 || arc4random_uniform(3)+1 == 2{
            print("I will add some gas now")
            car!.fuelLevel = Int(arc4random_uniform(50)+10)
            print("Added fuel.Curren fuel level \(car!.fuelLevel)")
        }else{
            print("I will add some gas later")
        }
    }
    func outOfFuel() {
        print("I will add some gas now")
        car!.fuelLevel = Int(arc4random_uniform(50)+10)
        print("Added fuel.Current fuel level \(car!.fuelLevel)")
    }
}

enum DrivingLicenceType{
    case A
    case B
    case C
    case D
}
var admirsLicences: Set<DrivingLicenceType> = [DrivingLicenceType.A, DrivingLicenceType.B]
var mechanicsLicences: Set<DrivingLicenceType> = [DrivingLicenceType.A, DrivingLicenceType.B, DrivingLicenceType.C]
var admir = Driver(firstName: "Admir", lastName: "Halep", age: 32, licences: admirsLicences)
var admirsCar = Car(name: "Golf", model: "VI", licenceType: DrivingLicenceType.B, fuelTank: 55, fuelLevel: 50)
var kenan = Mechanic(firstName: "Kenan", lastName: "Kahric", age: 20, authorizedServicerForLicenceTypes: mechanicsLicences)
admir.car = admirsCar
admirsCar.delegate = admir
admir.mechanic = kenan
for _ in 1...10{
   admir.driveCar()
}
delayedPrint("Car crossed \(admirsCar.crossedKilometers) kilometers in this run")
