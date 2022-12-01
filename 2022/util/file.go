package util

import (
	"io/ioutil"
	"strings"
)

func ReadFile(path string) string {
	// read the entire file & return the byte slice as a string
	content, err := ioutil.ReadFile(path)
	if err != nil {
		panic(err)
	}
	// trim off new lines and tabs at end of input files
	strContent := string(content)
	return strings.TrimRight(strContent, "\n")
}
