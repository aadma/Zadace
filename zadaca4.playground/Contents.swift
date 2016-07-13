//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"




//ZADATAK

//dio 1

//1)

struct Location{
    var latitude: Double
    var longitude: Double
    init(){
        latitude = Double(arc4random()%181) - 90.0
        longitude = Double(arc4random()%361) - 90.0
    }
}
var coords = Location()
coords.latitude
coords.longitude

//2)

class Person{
    var name: String
    var lastName: String
    var yearOfBirth: Int
    var age: Int{
        get{
            return 2016 - yearOfBirth
        }
        set{
         self.age = 2016 - newValue
        }
    }
    var location: Location
        init(name: String, lastName: String, yearOfBirth: Int, location: Location){
        self.name = name
        self.lastName = lastName
        self.yearOfBirth = yearOfBirth
        self.location = location
        }
    convenience init(name: String, lastName: String){
        self.init(name: name, lastName: lastName, yearOfBirth: 1990, location: coords)
        
    }
        func introduction()-> String{
        return "Hi my name is \(name) \(lastName) age \(age)"
    }
}
let mirko = Person(name: "Mirko", lastName: "Babic", yearOfBirth: 1987, location: coords)
let nedim = Person(name: "Nedim", lastName: "Sabic", yearOfBirth: 1982, location: coords)
mirko.introduction()
nedim.introduction()

//Dio 2

//1)
struct Course{
    var teacher: Person
    var courseName: String
    func aboutCourse()->String{
        return "\(courseName) course by prof. \(teacher.lastName)"
    }
}

//2)

class Student: Person{
    var attendingCourses: [Course]
    var grades: [Int]
    var faculty = "WiP"
    var averageGrade: Double{
        get{
            var total = 0
            for grade in grades{
                total += grade
            }
            return Double(total/grades.count)
        }
    }
    init(name: String, lastName: String, yearOfBirth: Int, location: Location, attendingCourses: [Course], grades: [Int]){
        self.attendingCourses = attendingCourses
        self.grades = grades
        super.init(name: name, lastName: lastName, yearOfBirth: yearOfBirth, location: location)
    }
    
    override func introduction() -> String {
        return "Hi my name is \(name) \(lastName) age \(age)" + " I am a student at \(faculty)." + " My favourite course is \(attendingCourses.first!.aboutCourse())"
    }

}

//3)

var iosDevelopment = Course(teacher: mirko, courseName: "iOS development")
var seo = Course(teacher: nedim, courseName: "SEO")
var courses = [seo, iosDevelopment]

let student = Student(name: "Admir", lastName: "Halep", yearOfBirth: 1983, location: coords, attendingCourses: courses, grades: [9,10,9,8,10])
student.introduction()