//: Playground - noun: a place where people can play

import UIKit

//petlje

for number in 1...3{
    print("\(number) times 5 is \(number*5)")
}

//sve dok je iterator manji od 5

for secondNumber in 1..<5{
  print("\(secondNumber) times 2 is \(secondNumber*2)")
}

// ignorisanje sa donjom crtom

for _ in 1...3{
 print("Hello")
}

//iteriranje kroz kolekcije

let names = ["Chuck", "Van Damme", "Stalone"]

for name in names{
  print(name)
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animal, legCount) in numberOfLegs{
    print("\(animal) has \(legCount) legs")
    //ne mogu se sabirati stringovi i integeri ovako: animal + " has "+ legCount, mora se castati integer u String(legCount)
}

//while petlja

var i = 5
while i > 0{
 print("Iteration \(i)")
    i -= 1
}

//repeat while

var count = 10
repeat{
 print(count)
    count -= 1
}while count > 0

//GRANANJE
//if, if else, if else if else

var temperature = 22

if temperature > 18{
    print("Let's go swimming")
}else if temperature <= 15 && temperature > 0{
    print("Let's take a walk")
}else{
    print("I think i am staying at home")
}

//switch
let char: Character = "a"

switch char{
    case "a", "e", "i", "o", "u":
    print("\(char) is a wovel")
default:
    print("\(char) is a consonant")
}

//intervali u switch-u

let age = 18

switch age{
case 1..<18:
    print("We have a minor")
default:
    print("He is an adult")
}

// kontrola transfera, continue prelazi u sljedecu iteraciju a break prekida

var string = "Hello world"
var stringWithoutWovels = ""

for character in string.characters{
    switch character{
    case "a", "e", "i", "o", "u":
        continue
    default:
        stringWithoutWovels.append(character)
    }
}
print(stringWithoutWovels)

let array = [2, 4, 6, -2, 8]

for num in array{
    if num > 0{
        print(num)
    }else{
        break
    }
}

var integerToDescribe = 5

var description = "\(integerToDescribe) is"
switch integerToDescribe{
case 2,3,5,7:
    description += " a prime number and also "
    fallthrough
default:
    description += "an integer"
    
}

let ages = [21, 24, 14, 37]

for person in ages{
    guard person > 18 else{
        print("Nice try")
        break
    }
    print("Ticket please")
}
for years in ages{
    if years > 18{
        print("Ticket please")
    }else{
        print("Nice try")
        break
    }
}