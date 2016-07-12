//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//strukture i klase

struct Resolution{

var width = 1360
var height = 760
    
}

class VideoMode{
 var resolution = Resolution()
    
var frameRate = 0.0
    var videoName: String?
}

let objResolution = Resolution()
let objVideoMode = VideoMode()
objResolution.height

let vga = Resolution(width: 640, height: 480)

//Value type i referentni

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 1024
hd.width
cinema.width

let tenEighty = VideoMode()
tenEighty.videoName = "Neokino"
tenEighty.resolution = hd
let anotherTenEighty = tenEighty
anotherTenEighty.frameRate = 30
tenEighty.frameRate
anotherTenEighty.frameRate

let tenEighty1 = VideoMode()


tenEighty === anotherTenEighty

tenEighty === tenEighty1

//polja

struct SomeStructure {
    var firstField: Int
    let secondField: Int
}

var instanceOfStructure = SomeStructure(firstField: 2, secondField: 5)
instanceOfStructure.firstField

//ako je instanca strukture konstanta onda se polja ne mogu mijenjati

let anotherInstanceOfStructure = SomeStructure(firstField: 3, secondField: 7)
//anotherInstanceOfStructure.firstField = 8 greska


//lazy var

class Image{
    static func load1000Images() ->[Image]?{
        //ko fol vraca 1000 slika
        return nil
    }
}

class VideoManager{
 lazy var images = Image.load1000Images()
    var albumName = "1000 images"
}

//lazy vars nemaju vrijednost sve dok ih ne pozovemo
let instanceOfVideoMAnager = VideoManager()
instanceOfVideoMAnager.albumName
instanceOfVideoMAnager.images


//computed property

struct Alpha{

    var a = 0.0
    
    var square: Double{
        get{
         return 6 * a * a
        }
        set{
         a = sqrt(newValue/6.0)
        }
    }
}
var instanceOfAlpha = Alpha(a: 10.0)
instanceOfAlpha.square // geter vratio
instanceOfAlpha.square = 6  //seter izracunao
instanceOfAlpha.a


//static properties

class Game{
    static var gamesPlayed = 0
    var gameScore = 0
    
    //inicijalizator koji povecava broj odigranih igara prilikom svakog instanciranja
    init(){
        Game.gamesPlayed += 1
    }
}
var newGame = Game()
newGame.gameScore = 70
var anotherGame = Game()
anotherGame.gameScore = 100
Game.gamesPlayed //odigrane dvije igre
var thirdGame = Game()
Game.gamesPlayed // and so on



struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) ->Bool{
        return self.x > x //self se odnosi na property x a ne na argument funkcije i koristi se kad imaju isti naziv
    }
}
let point = Point(x: 3, y: 2)
point.isToTheRightOfX(1.0)

//staticke metode

class Game2{
    static var gamesPlayed = 10
    static func numberOfGames(){
     print("There has been \(gamesPlayed) games played")
    }
}


Game2.numberOfGames()
Game2.gamesPlayed = 15
Game2.numberOfGames()

//nasljedjivanje

class Vehicle{
    var currentSpeed = 0
    var description: String{
        return "Is traveling at \(currentSpeed) kilometers per hour"
    }
    func makeNoise(){
    
    }
}
var golfVI = Vehicle()
golfVI.currentSpeed = 120
print(golfVI.description)


class Bycicle: Vehicle{
    var hasBasket = false
}
let someBycicle = Bycicle()
someBycicle.hasBasket = true
someBycicle.currentSpeed = 15
print(someBycicle.description)


//override(preklapanje)

class Brum: Vehicle{
    override func makeNoise() {
        print("Brum brum")
    }
}
let brum = Brum()
brum.makeNoise() //nece ispisati u playgroundu

class Car: Vehicle{
    var gear = 1
    override var description: String{
        return super.description + " in gear \(gear)"
        //kljucna rijec super poziva roditeljsku klasu
    }
}
let car = Car()
car.gear = 4
car.currentSpeed = 70
print(car.description)

//inicijalizacija

struct Farenheit{
    var temperature: Double
    init(){
        temperature = 32.0
    }
}
let farenheit = Farenheit()
farenheit.temperature

struct Celsius {
    var temperatureInCelsius: Double
    
    //inicijalizacija sa parametrima
    init(fromFarenheit farenheit: Double){
        temperatureInCelsius = (farenheit - 32.0)/1.8
    }
    init(fromKelvin kelvin: Double){
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFarenheit: 212.0)
boilingPointOfWater.temperatureInCelsius

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
freezingPointOfWater.temperatureInCelsius

//convenience init(kad ne proslijedimo parametre prilikom instanciranja, u ovom slucaju ce da pozove prethodni init i dodjeli ime Unnamed)

class Food {
    var name: String
    init(name: String){
        self.name = name
    }
    convenience init(){
        self.init(name: "[Unnamed]")
        //delegiranje moguce samo u klasama
    }
}
let foodWithParameter = Food(name: "chicken")
let foodNoParameter = Food()
foodWithParameter.name
foodNoParameter.name

class Ingredients: Food{
    var quantity: Int
    init(name: String, quantity: Int){
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String){
        self.init(name: name, quantity: 1)
    }
}
let mysteryMeat = Ingredients()
mysteryMeat.name
mysteryMeat.quantity
let favoriteMeat = Ingredients(name: "Chevapi", quantity: 10)

struct Animal{
    let species: String
    init?(species: String){
        if species.isEmpty{return nil}
        self.species = species
    }
}

let animal = Animal(species: "Cat")

let unknownAnimal = Animal(species: "")