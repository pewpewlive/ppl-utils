package main

import (
	"errors"
	"fmt"
	"log"
	"net/http"
	"strings"
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
		fmt.Fprintf(w, "level_id = \"/dev/%s\"\n", level.directory)
		fmt.Fprint(w, "},\n")
	}
	fmt.Fprint(w, "}\n")
	fmt.Fprint(w, "}")
}

func getStrippedLevelID(r *http.Request) (string, error) {
	levelID := r.FormValue("level_id")
	if levelID == "" {
		return "", errors.New("Missing level_id paramenter in request")
	}
	if !strings.HasPrefix(levelID, "/dev/") {
		return "", errors.New("level_is is not prefixed with /dev/")
	}
	return levelID[5:], nil
}

func getLevel(w http.ResponseWriter, r *http.Request) {
	setHeaders(w, r)
	var strippedLevelID, err = getStrippedLevelID(r)
	if err != nil {
		log.Print(err.Error())
		return
	}
	levelData, err := GetLevelData(strippedLevelID)
	if err != nil {
		log.Print(err.Error())
		return
	}
	w.Write(levelData.Bytes())
}

func getLevelManifest(w http.ResponseWriter, r *http.Request) {
	setHeaders(w, r)
	var strippedLevelID, err = getStrippedLevelID(r)
	if err != nil {
		log.Print(err.Error())
		return
	}
	levelManifest, err := GetLevelManifest(strippedLevelID)
	if err != nil {
		log.Print(err.Error())
		return
	}
	w.Write(levelManifest)
}

func main() {
	// Serves the static files
	fs := cacheControlWrapper(http.FileServer(http.Dir(GetDir())))
	http.Handle("/", fs)

	http.HandleFunc("/custom_levels/list", list)
	http.HandleFunc("/custom_levels/get_level", getLevel)
	http.HandleFunc("/custom_levels/get_level_manifest", getLevelManifest)

	log.Print("Starting server on port 9000")
	log.Print("open http://localhost:9000/pewpew.html to run PewPew")
	log.Fatal(http.ListenAndServe(":9000", nil))
}
