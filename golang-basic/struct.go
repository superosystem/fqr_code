package main

import "fmt"

type Customer struct {
	Name, Address string
	Age           int
}

func (customer Customer) sayHi(name string) {
	fmt.Println("Hello", name, "My Name is", customer.Name)
}

func (a Customer) sayHuuu() {
	fmt.Println("Huuuuuu from", a.Name)
}

func main() {
	var Agus Customer
	Agus.Name = "Agus"
	Agus.Address = "Indonesia"
	Agus.Age = 30

	Agus.sayHi("Joko")
	Agus.sayHuuu()

	//fmt.Println(Agus.Name)
	//fmt.Println(Agus.Address)
	//fmt.Println(Agus.Age)
	//
	//joko := Customer{
	//	Name:    "Joko",
	//	Address: "Cirebon",
	//	Age:     35,
	//}
	//fmt.Println(joko)
	//
	//budi := Customer{"Budi", "Jakarta", 35}
	//fmt.Println(budi)
}
