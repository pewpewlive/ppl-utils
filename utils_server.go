package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strings"
)

func getDir() string {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		log.Fatal(err)
	}
	dir = dir + string(os.PathSeparator) + "content"
	return dir
}

func printIndex(res http.ResponseWriter, req *http.Request) {
	prefix := getDir() + string(os.PathSeparator) + "dynamic"
	log.Print("Listing files in " + prefix)
	err := filepath.Walk(getDir(),
		func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}
			log.Print("* " + path)
			filename := filepath.Base(path)
			if filename[0] != '.' && strings.HasPrefix(path, prefix) {
				trimmed := strings.TrimPrefix(path, getDir())
				// On windows the separators are different.
				trimmed_fixed := strings.ReplaceAll(trimmed, string(os.PathSeparator), "/")
				fmt.Fprint(res, trimmed_fixed, "\n")
			}
			return nil
		})
	if err != nil {
		log.Println(err)
	}
}

func cacheControlWrapper(h http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Cache-Control", "max-age=0")
		h.ServeHTTP(w, r)
	})
}

func main() {
	fs := cacheControlWrapper(http.FileServer(http.Dir(getDir())))
	http.HandleFunc("/index/", printIndex)
	http.Handle("/files/", http.StripPrefix("/files", fs))
	http.HandleFunc("/", func(res http.ResponseWriter, req *http.Request) {
		res.Header().Set("Content-Type", "text/html")
		fmt.Fprint(res, "<a href=\"files/pewpew.html\">PewPew</a>")
	})
	log.Print("Starting server on port 9000")
	log.Print("open http://localhost:9000/files/pewpew.html to run PewPew")
	log.Fatal(http.ListenAndServe(":9000", nil))
}
