package main

import "fmt"

func getFullName() (string, string, string) {
	return "Agus", "Syahril", "Mubarok"
}

func main() {
	firstName, _, _ := getFullName()
	fmt.Println(firstName)
	// fmt.Println(middleName)
	// fmt.Println(lastName)
}
