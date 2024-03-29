Object subclass: Employee [
    |firstName lastName|

    setFirstName: aString [
        "An instance method to set the first name of the employee"
        firstName := aString.
    ]

    getFirstName [
        "An instance method to get the first name of the employee"
        ^firstName.
    ]

    setLastName: aString [
        "An instance method to set the last name of the employee"
        lastName := aString.
    ]

    getLastName [
        "An instance method to get the last name of the employee"
        ^lastName.
    ]

    getEarning [
        "An instance method to get the earning of the employee"
        ^0.0.
    ]

    printInfo [
        "An instance method to get the information of the employee"
        ^firstName, ' ', lastName.
    ]
]