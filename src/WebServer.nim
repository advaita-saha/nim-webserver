import
  htmlgen,
  jester,
  json,
  norm/[model, sqlite]

type
  Employee = ref object of Model
    firstName, lastName: string
    company: Company

  Company = ref object of Model
    name: string

func newCompany(name = ""): Company =
  Company(name: name)

func newEmployee(firstName = "", lastName = "", company = newCompany()): Employee =
  Employee(
    firstName: firstName,
    lastName: lastName,
    company: company
  )

let dbconn = open(":memory:", "", "", "")

settings:
  port = Port(4000)
  bindAddr = "127.0.0.1"

routes:
  get "/":
    resp h1("Hello World")

  post "/deploy":
    dbconn.createTables(newEmployee())
    var eCorp = newCompany("ECorp")
    var fooBar = newCompany("FooBar")
    var employees = [
      newEmployee("Peter", "Miller", eCorp),
      newEmployee("Michael", "Baz", fooBar)
    ]
    dbconn.insert(employees)
    resp "Deployment Completed"

  get "/employees":
    var employees = @[newEmployee()]
    dbconn.select(employees, "Employee.firstname = ?", "Peter")
    resp %*employees[0]