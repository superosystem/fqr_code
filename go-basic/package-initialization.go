package main

import (
	"go-basic/database"
	"fmt"
)

func main() {
	result :=  database.GetDatabase()
	fmt.Println(result)
}
