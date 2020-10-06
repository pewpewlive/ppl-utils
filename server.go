package main

import (
	"fmt"
	"log"
	"net/http"
)

func setHeaders(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Headers", "*")
	w.Header().Set("Cache-Control", "no-store")
}

func cacheControlWrapper(h http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		setHeaders(w, r)
		h.ServeHTTP(w, r)
	})
}

func list(w http.ResponseWriter, r *http.Request) {
	setHeaders(w, r)
	levels := ListLevels()
	fmt.Fprint(w, "data = {\n")
	fmt.Fprint(w, "levels = {\n")
	for _, level := range levels {
		fmt.Fprint(w, "{\n")
		fmt.Fprintf(w, "name = \"%s\",\n", level.name)
		fmt.Fprintf(w, "author = \"%s\",\n", level.author)
		fmt.Fprintf(w, "level_id = \"%s\"\n", level.directory)
		fmt.Fprint(w, "},\n")
	}
	fmt.Fprint(w, "}\n")
	fmt.Fprint(w, "}")
}

func getLevel(w http.ResponseWriter, r *http.Request) {
	setHeaders(w, r)
	levelId := r.FormValue("level_id")
	levelData := GetLevelData(levelId)
	w.Write(levelData.Bytes())
}

func main() {
	// Serves the default page
	// http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
	// 	setHeaders(w, r)
	// 	w.Header().Set("Content-Type", "text/html")
	// 	fmt.Fprint(w, "<a href=\"files/pewpew.html\">PewPew</a>")
	// })
	// Serves the static files
	fs := cacheControlWrapper(http.FileServer(http.Dir(GetDir())))
	http.Handle("/", fs)

	// http.Handle("/files/", fs)

	// Serves the list of levels
	http.HandleFunc("/custom_levels/list", list)
	// Serves the zip for a given level
	http.HandleFunc("/custom_levels/get_level", getLevel)

	log.Print("Starting server on port 9000")
	log.Print("open http://localhost:9000/files/pewpew.html to run PewPew")
	log.Fatal(http.ListenAndServe(":9000", nil))
}
