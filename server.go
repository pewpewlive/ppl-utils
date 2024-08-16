package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
)

func setHeaders(w http.ResponseWriter, _ *http.Request) {
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
	levels := ListLevels(GetDir())
	jsonStr, marshalingError := json.Marshal(levels)
	if marshalingError != nil {
		http.Error(w, marshalingError.Error(), http.StatusInternalServerError)
		return
	}
	fmt.Fprint(w, string(jsonStr))
}

func getStrippedLevelID(r *http.Request) (string, error) {
	levelID := r.FormValue("level_uuid")
	if levelID == "" {
		return "", errors.New("missing level_id paramenter in request")
	}
	return levelID, nil
}

func getLevel(w http.ResponseWriter, r *http.Request) {
	setHeaders(w, r)
	var strippedLevelID, err = getStrippedLevelID(r)
	if err != nil {
		log.Print(err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	levelData, err := GetLevelData(strippedLevelID, len(os.Args) > 1 && os.Args[1] == "--disable-ext-filter")
	if err != nil {
		log.Print("Failed to GetLevelData:" + err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Write(levelData.Bytes())
}

func getLevelManifest(w http.ResponseWriter, r *http.Request) {
	setHeaders(w, r)
	var strippedLevelID, err = getStrippedLevelID(r)
	if err != nil {
		log.Print(err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	levelManifest, err := GetLevelManifest(strippedLevelID)
	if err != nil {
		log.Print(err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Write(levelManifest)
}

func main() {
	// Serves the static files
	fs := cacheControlWrapper(http.FileServer(http.Dir(GetDir())))
	http.Handle("/", fs)

	http.HandleFunc("/custom_levels/get_public_levels", list)
	http.HandleFunc("/custom_levels/get_level", getLevel)
	http.HandleFunc("/custom_levels/get_level_manifest", getLevelManifest)

	log.Print("Starting server on port 9000")
	log.Print("open http://localhost:9000/pewpew.html to run PewPew")
	log.Fatal(http.ListenAndServe(":9000", nil))
}
