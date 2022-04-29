package main

import (
	"fmt"
	"strings"
)

func main() {
	fmt.Println(strings.Contains("Agus Syahril", "Agus"))
	fmt.Println(strings.Contains("Agus Syahril", "Budi"))

	fmt.Println(strings.Split("Agus Kurniawna Mubarok", " "))

	fmt.Println(strings.ToLower("Agus Syahril Mubarok"))
	fmt.Println(strings.ToUpper("Agus Syahril Mubarok"))
	fmt.Println(strings.ToTitle("Agus Syahril Mubarok"))

	fmt.Println(strings.Trim("      Agus Syahril     ", " "))
	fmt.Println(strings.ReplaceAll("Agus Joko Agus", "Agus", "Budi"))
}
