# PrettyPrintable
Protocol which allows adopters to retrieve a pretty string representation (`description`) of themselves rather than the default Swift object notation

Consider the following classes with some simple stored properties:

    class TestObject {
        var string: String = "id"
        var int: Int = 1234
        var double: Double = 1234.1234
        var array: [String] = ["first", "second", "third", ]
        var dictionary: [String:Any] = ["first": "id": "second": 1234, "third": 1234.1234, ]
        var object: AnotherTestObject = AnotherTestObject()
    }

    class AnotherTestObject {
        var string: String = "anotherID"
        var int: Int = 4321
        var double: Double = 4321.4321
        var array: [String] = ["third", "second", "first", ]
        var dictionary: [String:Any] = ["third": 4321.4321, "second": 4321, "first": "anotherID", ]
    }

These classes, when sent to the console via `print()`, will usually output in the following manner:

    "<TestObject: 0x600000011450>\n"
    "<AnotherTestObject: 0x600000011450>\n"

While this does describe the object type and memory location, this information is typically not as useful, especially while debugging, as seeing the actual contents of the object. By making some small modifications, we can take advantage of the PrettyPrintable protocol and some standard KVC to produce much prettier and easier to read logs for our console:

    import PrettyPrint
    
    class TestObject: PrettyPrintable {
        var string: String = "id"
        var int: Int = 1234
        var double: Double = 1234.1234
        var array: [String] = ["first", "second", "third", ]
        var dictionary: [String:Any] = ["first": "id": "second": 1234, "third": 1234.1234, ]
        var object: AnotherTestObject = AnotherTestObject()
    }
    
    class AnotherTestObject: PrettyPrintable {
        var string: String = "anotherID"
        var int: Int = 4321
        var double: Double = 4321.4321
        var array: [String] = ["third", "second", "first", ]
        var dictionary: [String:Any] = ["third": 4321.4321, "second": 4321, "first": "anotherID", ]
    }
    
    print(TestObject())

Using the above code, our console will display the following:

    TestObject: {
        string: id,
        int: 1234,
        double: 1234.1234,
        array: [
            first,
            second,
            third,
        ],
        dictionary: [
            first: id,
            second: 1234,
            third: 1234.1234,
        ],
        object: {
            string: anotherID,
            int: 4321,
            double: 4321.4321,
            array: [
                third,
                second,
                first,
            ],
            dictionary: [
                third: 4321.4321,
                second: 4321,
                first: anotherID,
            ],
        },
    }

Note that the properties may not necessarily display in the same order they are defined. Also, in Swift, dictionaries are not ordered; because of this, they will not be printed the same way every time when using PrettyPrintable.

Since PrettyPrintable is freely open source, this implementation could be modified to produce slightly different formatting. Please report any questions or concerns to Michael (mtfourre) here on Github.
