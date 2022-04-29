package main

import "fmt"

func sayHelloTo(firstName string, lastName string) {
	fmt.Println("Hello", firstName, lastName)
}

func main() {
	firstName := "Agus"
	sayHelloTo(firstName, "Syahril")
	sayHelloTo("Budi", "Nugraha")
}
