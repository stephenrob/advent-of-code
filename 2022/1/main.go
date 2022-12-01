package main

import (
	"flag"
	"fmt"
	"regexp"
	"sort"
	"strconv"

	"github.com/stephenrob/advent-of-code/util"
)

func main() {
	var part int
	var file string

	flag.IntVar(&part, "part", 1, "Part of the problem to solve")
	flag.StringVar(&file, "file", "input.txt", "Input file")
	flag.Parse()

	fmt.Printf("Solving part %d\n", part)

	switch part {
	case 1:
		fmt.Println("Result: ", puzzle1(util.ReadFile(file)))
	case 2:
		fmt.Println("Result: ", puzzle2(util.ReadFile(file)))
	default:
		panic("Invalid part specified")
	}

}

func puzzle1(input string) int {
	var totalElfCalories = []int{}

	elfCalories := parseInput(input)

	for _, v := range elfCalories {
		totalElfCalories = append(totalElfCalories, util.SumSlice(v))
	}

	sort.Ints(totalElfCalories)

	return totalElfCalories[len(totalElfCalories)-1]

}

func puzzle2(input string) int {
	var totalElfCalories = []int{}

	elfCalories := parseInput(input)

	for _, v := range elfCalories {
		totalElfCalories = append(totalElfCalories, util.SumSlice(v))
	}

	sort.Ints(totalElfCalories)

	return util.SumSlice(totalElfCalories[len(totalElfCalories)-3:])
}

func parseInput(input string) [][]int {

	var parsedInput = [][]int{}

	splitString := regexp.
		MustCompile(`\n\s*\n`).
		Split(input, -1)

	for _, v := range splitString {
		var elfCalories = []int{}
		splitElf := regexp.MustCompile(`\n`).Split(v, -1)
		for _, v := range splitElf {
			calories, err := strconv.Atoi(v)
			if err != nil {
				panic(err)
			}
			elfCalories = append(elfCalories, calories)
		}

		parsedInput = append(parsedInput, elfCalories)
	}

	return parsedInput
}
