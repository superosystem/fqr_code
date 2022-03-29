package main

import (
	"go-basic/helper"
	"fmt"
)

func main() {
	helper.SayHello("Agus")
	// helper.sayGoodbye("Agus") // error
	fmt.Println(helper.Application)
	// fmt.Println(helper.version) // error
}
