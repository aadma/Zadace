//: Playground - noun: a place where people can play

import UIKit

//varijable i konstante
var str = "Hello, playground"
let aadma = "ja sMa aadma :)"
let pi: Double = 3.14
var numberOfSamples: Int = 10

//type inference
let piInfered = 3.14
print("pi \(pi) is same as \(piInfered)")

//komentari

//single line
/* multi
 line comment
 koji ide u vise
 redova*/

//opcionali i opcionalno vezivanje

var kamion: String!
kamion = "MAN"
var auto: String?
print(kamion)
//auto = "VW"

if let vozilo = auto{
 print(vozilo)
}

//operatori dodjeljivanja

let a = 10
var b = 6
b = a
let c = b

//struct learned online

struct workInProgress{
    let name: String
    let email: String? //opcional, tvrdimo da email mozda postoji a mozda ne, tip je string
}

//instanciranje objekta
let studentWithEmail = workInProgress(name: "Admir", email: "admir.halep@outlook.com")
let studentWithoutEmail = workInProgress(name: "Aadma", email: nil)

//funkcija koja ce ispisati dva razlicita rezultata zato sto drugi student nema email
func describeStudent(student: workInProgress){
    if let studentEmail = student.email{
    
        print("Student \(student.name) has an email and it's \(studentEmail)")
    
    }else{
        
        print("Student \(student.name) has no email")
    }
}

//funckiju describeStudent cemo pozvati dva puta i proslijediti joj objekte kao parametre
describeStudent(studentWithEmail)
describeStudent(studentWithoutEmail)

//aritmetika
2 + 2

7.5 + 2.5

"hello" + " " + "world"

"zdravo" + " jesi za kafu"

//ostatak pri djeljenju
7 % 2
10 % 5

//unarni operatori
let three = 3
let minusThree = -three
let alsoMinusThree = +minusThree

//kompozitni operatori

var e = 1
e += 2
e *= 4
e /= 2
e -= 2

//operatori poredjenja

let f = 7
e == f
e > f
e < f
e <= f
e >= f
e != f

//ternarni operator

let minusTwo = -2
print(minusTwo < 0 ? "Negative":"Positive")
//ako je uslov prije upitnika tacan onda se vraca vrijednost sa lijeve strane dvotacke, u suprotnom sa desne

//operator ??

var deliciousFood: String?
print(deliciousFood ??  "Chevapi")
//ukolio ne postoji promjenljiva deliciousFood onda ce vratiti Chevapi

//logicki operatori

var lightsOn = true  //boolian true
if lightsOn == true{
    lightsOn = false //switch to boolian false
}
var isTired = true

if lightsOn == false && isTired == true{
    print("go to sleep")
}


var musicPlays = true
var weDance = true
if musicPlays == true{
    musicPlays = false
}
if weDance == true && !musicPlays{
    print("Let the music play")
}

//intervali

for i in 1...3{
 print(i)
}

for i in 0..<3{
    print(i)
}

let time = 2.30

if (isTired == true && lightsOn == false) || time < 3.00{
    print("Goodnight")
}

//stringovi i karakteri
let emptyString = ""
let nonEmptyString = "There is something in here"

emptyString.isEmpty
nonEmptyString.isEmpty

var together = "Ying"
together += " Yang"

//karakteri

for letters in "BiH".characters{
    print(letters)
}

let arrayOfCharacters: [Character] = ["p","e","a","c","e"] //must declare type

for peace in arrayOfCharacters{
    print(peace)
}

let peaceStringOuttaArrayOfCharacters = String(arrayOfCharacters)

//konkatenacija

var proverb = "Big things" + " have" + " " + "small begginings"
var exclamation: Character = "!"
proverb.append(exclamation)

//interpolacija 
let five = 5
let six = 6
let result = "\(five) times \(six) equals \(five*six)"
"More complex example: \((five*six)/(six-five))"
"\"He is lost in a wilderness, he is lost in bitterness \"\n James Brown"

//nizovi

var myEmptyArray = [String]()
var nonEmptyArray = [3,5]
nonEmptyArray.append(7)

var arrOne = ["one","two"]
var arrTwo = ["three","four"]
let arrSubstract = arrOne + arrTwo //jednostavno zbrajanje
arrSubstract.count
arrSubstract.isEmpty

//skupovi

var genres: Set<String> = ["rock", "metal", "hip hop"]
genres.insert("rock")




