
import UIKit

struct Location{
    var latitude: Double
    var longitude: Double
    init(){
        latitude = Double(arc4random() % 181) - 90.0
        longitude = Double(arc4random() % 361) - 90.0
    }
}
var coords = Location()
var newCoords = Location()
var coords3 = Location()
var coords4 = Location()

// ZADATAK 2
class Parent: Person{
    var children: [Person]
    var savings: Double?
    init(name: String, lastName: String, yearOfBirth: Int, location: Location, children: [Person]){
        self.children = children
        super.init(name: name, lastName: lastName, yearOfBirth: yearOfBirth, location: location)
    }
    convenience init(name: String, lastName: String){
        self.init(name: name, lastName: lastName, yearOfBirth: 1946, location: coords3, children: [Person]())
        self.children = [Person]()
    }
}

extension Int {
    mutating func daysInAge(){
        self = self * 360
    }
}

class Person{
    var name: String
    var lastName: String
    var yearOfBirth: Int
    var age: Int{
        return 2016 - yearOfBirth
    }
    weak var father: Parent?
    weak var mother: Parent?
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
        return "Hi my name is \(name) \(lastName) age \(age)."
    }
}

let mirko = Person(name: "Mirko", lastName: "Babic", yearOfBirth: 1987, location: coords)
let nedim = Person(name: "Nedim", lastName: "Sabic", yearOfBirth: 1982, location: newCoords)
mirko.introduction()
nedim.introduction()

struct Course{
    var teacher: Person
    var courseName: String
    func aboutCourse()->String{
        return  "\(courseName) course by prof. \(teacher.lastName)"
    }
}

class Student: Person{
    var attendingCourses: [Course]?
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
    override func introduction() -> String{
        var introduceStudent = " I am a student at \(faculty)."
        if let attendingCourse = attendingCourses{
            introduceStudent += "My favourite course is \(attendingCourse.first!.aboutCourse())."
        }
        if (father?.savings) == nil && (mother?.savings) == nil{
            introduceStudent += "My parents are broke"
        }
        if let fatherSavings = father?.savings{
            introduceStudent += "My father has $\(fatherSavings) savings."
        }
        if let motherSavings = mother?.savings{
            introduceStudent += "My mother has $\(motherSavings) savings."
        }
        return super.introduction() + introduceStudent
    }
}

var iosDevelopment = Course(teacher: mirko, courseName: "iOS development")
var seo = Course(teacher: nedim, courseName: "SEO")
var courses = [seo, iosDevelopment]
let student = Student(name: "Admir", lastName: "Halep", yearOfBirth: 1983, location: coords3, attendingCourses: courses, grades: [9,10,9,8,10])
student.introduction()
let aida = Person(name: "Aida", lastName: "Durmisevic", yearOfBirth: 1972, location: coords4)
var ismet = Parent(name: "Ismet", lastName: "Halep", yearOfBirth: 1946, location: coords3, children: [aida , student])
var ilduza = Parent(name: "Ilduza", lastName: "Halep", yearOfBirth: 1951, location: coords3, children: [aida, student])
ismet.savings = Double(arc4random() % 10000)
ilduza.savings = Double(arc4random() % 10000)
student.father = ismet
student.mother = ilduza
ismet.savings
student.introduction()
ismet.introduction()
var days = student.age
days.daysInAge()
