package main

import (
    "log"
    "fmt"
		"net/http"
		"path/filepath"
		"os"
		"strings"
)

func getDir() string {
	return "."
}

func printIndex(res http.ResponseWriter, req *http.Request) {
	err := filepath.Walk(getDir(),
		func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}
			filename := filepath.Base(path)
			if (filename[0] != '.' && strings.HasPrefix(path, "dynamic/")) {
				fmt.Fprint( res, path, "\n")
			}
			return nil
		})
	if err != nil {
		log.Println(err)
	}
}

func main() {
		fs := http.FileServer( http.Dir( getDir() ) )
		
		http.HandleFunc("/index/", printIndex)

		http.Handle( "/files/", http.StripPrefix( "/files", fs ) )
		
    http.HandleFunc( "/", func( res http.ResponseWriter, req *http.Request ) {
        res.Header().Set( "Content-Type", "text/html" );
        fmt.Fprint( res, "<h1>ppl-extras server is running</h1>" )
    } )

		log.Print("Starting server on port 9000")
		log.Print("open http://localhost:9000/files/pewpew.html to run PewPew")
    log.Fatal(http.ListenAndServe( ":9000", nil ))
}