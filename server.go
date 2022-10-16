package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
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
	levels := ListLevels(GetDir())
	jsonStr, marshalingError := json.Marshal(levels)
	if marshalingError != nil {
		http.Error(w, marshalingError.Error(), http.StatusInternalServerError)
		return
	}
	fmt.Fprintf(w, string(jsonStr))
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

func udp_server() {
	local_addr, err := net.ResolveUDPAddr("udp4", ":9001")
	if err != nil {
		panic(err)
	}
	last_buf := make([]byte, 4)
	for {
		conn, err := net.ListenUDP("udp4", local_addr)
		if err != nil {
			log.Print(err)
			conn.Close()
			continue
		}
		buf := make([]byte, 4)
		_, addr, err := conn.ReadFromUDP(buf)
		if err != nil {
			log.Print(err)
			conn.Close()
			continue
		}
		if bytes.Equal(last_buf, buf) {
			log.Print("Dropping duplicate pings")
			conn.Close()
			continue
		}
		addr.Port = 9002
		_, err = conn.WriteToUDP(buf, addr)
		if err != nil {
			log.Print(err)
			conn.Close()
			continue
		}
		conn.Close()
	}
}

func main() {
	// Serves the static files
	fs := cacheControlWrapper(http.FileServer(http.Dir(GetDir())))
	http.Handle("/", fs)

	http.HandleFunc("/custom_levels/list2", list)
	http.HandleFunc("/custom_levels/get_level", getLevel)
	http.HandleFunc("/custom_levels/get_level_manifest", getLevelManifest)

	log.Print("Starting server on port 9000")
	log.Print("open http://localhost:9000/pewpew.html to run PewPew")

	go udp_server()

	log.Fatal(http.ListenAndServe(":9000", nil))
}
