package main

import (
	"reflect"
	"testing"

	"github.com/stephenrob/advent-of-code/util"
)

func TestPuzzle1(t *testing.T) {
	tests :=
		[]struct {
			name  string
			input string
			want  int
		}{
			{
				"Most Calories", util.ReadFile("input_test.txt"), 24000,
			},
		}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := puzzle1(tt.input); got != tt.want {
				t.Errorf("puzzle1() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestPuzzle2(t *testing.T) {
	tests :=
		[]struct {
			name  string
			input string
			want  int
		}{
			{
				"Total Calories (top 3)", util.ReadFile("input_test.txt"), 45000,
			},
		}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := puzzle2(tt.input); got != tt.want {
				t.Errorf("puzzle2() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestParseInput(t *testing.T) {
	tests :=
		[]struct {
			name  string
			input string
			want  [][]int
		}{
			{
				"Inputs", util.ReadFile("input_test.txt"), [][]int{{1000, 2000, 3000}, {4000}, {5000, 6000}, {7000, 8000, 9000}, {10000}},
			},
		}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			if got := parseInput(tt.input); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("parseInput() = %v, want %v", got, tt.want)
			}
		})
	}
}
