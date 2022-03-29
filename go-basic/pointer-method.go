package main

import "fmt"

type Man struct {
	Name string
}

func (man *Man) Married() {
	man.Name = "Mr. " + man.Name
}

func main() {
	Agus := Man{"Agus"}
	Agus.Married()

	fmt.Println(Agus.Name)
}
