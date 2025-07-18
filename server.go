package main

import (
	"embed"
	"encoding/json"
	"errors"
	"fmt"
	"io/fs"
	"log"
	"net/http"
	"os"
	"path/filepath"
)

//go:embed webasm/pewpew.*
//go:embed webasm/pewpewlive.*
var webasmFS embed.FS

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
		return "", errors.New("missing level_uuid paramenter in request")
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
	levelManifest, err := GetLevelManifestWithExtraInfo(strippedLevelID)
	if err != nil {
		log.Print(err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Write(levelManifest.Bytes())
}

func main() {
	// Change the current working directory to the directory of the executable
	// Necessary to serve the levels if the binary is launched from an
	// arbitrary directory.
	executablePath, err := os.Executable()
	if err != nil {
		log.Print("Error getting executable path:", err)
		return
	}
	executableDir := filepath.Dir(executablePath)
	err = os.Chdir(executableDir)
	if err != nil {
		log.Print("Error changing directory:", err)
		return
	}

	// Serve the static files
	trimmedFS, trimmErr := fs.Sub(webasmFS, "webasm")
	if trimmErr != nil {
		log.Print("Error trimming directory:", trimmErr)
		return
	}
	fsHandler := cacheControlWrapper(http.FileServerFS(trimmedFS))
	http.Handle("/", fsHandler)

	// Serve the levels
	http.HandleFunc("/custom_levels/get_public_levels_v2", list)
	http.HandleFunc("/custom_levels/get_level", getLevel)
	http.HandleFunc("/custom_levels/get_level_manifest3", getLevelManifest)

	log.Print("Starting server on port 9000")
	log.Print("open http://localhost:9000/pewpew.html to run PewPew")
	log.Fatal(http.ListenAndServe(":9000", nil))
}
