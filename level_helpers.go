package main

import (
	"archive/zip"
	"bytes"
	"encoding/json"
	"errors"
	"io"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"
	"time"
)

// LevelJSON is used to write the list of levels
type LevelJSON struct {
	Name            string `json:"name"`
	Author          string `json:"author"`
	LevelID         string `json:"level_id"`
	Date            string `json:"date"`
	PublishState    int    `json:"publish_state"`
	Experimental    bool   `json:"experimental"`
	LeaderboardKind int    `json:"leaderboard_kind"`
}

// LevelManifest stores the manifest of a level.
type LevelManifest struct {
	Name                string `json:"name"`
	Description         string `json:"description"`
	EntryPoint          string `json:"entry_point"`
	HasScoreLeaderboard bool   `json:"has_score_leaderboard"`
}

// GetDir returns the path to the content directory.
func GetDir() string {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		log.Print(err.Error())
		return ""
	}
	dir = dir + string(os.PathSeparator) + "content"
	return dir
}

// ListLevels lists the levels.
// A level is a subdirectory that contains a properly formatted json file.
func ListLevels() []LevelJSON {
	levels := []LevelJSON{}

	filepath.Walk(GetDir(),
		func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}
			directory, filename := filepath.Split(path)

			if filename != "manifest.json" {
				return nil
			}

			jsonContent, err := ioutil.ReadFile(path)

			levelManifest := &LevelManifest{}
			err = json.Unmarshal(jsonContent, levelManifest)
			if err != nil {
				return err
			}

			level := new(LevelJSON)
			directory = strings.ReplaceAll(directory, string(os.PathSeparator), "/")
			level.Name = levelManifest.Name
			level.Author = "TBD"
			level.LevelID = directory
			level.Date = "---"
			level.Experimental = true
			level.PublishState = 0
			if levelManifest.HasScoreLeaderboard {
				level.LeaderboardKind = 1
			} else {
				level.LeaderboardKind = 0
			}
			levels = append(levels, *level)
			return nil
		})

	return levels
}

func canRead(path string) bool {
	_, err := os.Stat(path)
	if err == nil {
		return true
	}
	return false
}

// GetLevelData returns a zip containing the level.
// levelID is the path to the directory containing the level.
func GetLevelData(levelID string) (bytes.Buffer, error) {
	var buffer bytes.Buffer
	if !canRead(levelID) {
		return buffer, errors.New("Can't read path")
	}
	zipWriter := zip.NewWriter(&buffer)
	defer zipWriter.Close()

	filepath.Walk(levelID,
		func(path string, info os.FileInfo, err error) error {
			log.Print(path)
			path = strings.ReplaceAll(path, string(os.PathSeparator), "/")
			var header zip.FileHeader
			header.Name = "level/" + strings.TrimPrefix(path, levelID)
			header.Method = zip.Deflate
			header.Modified = time.Now()
			zipFileWriter, err := zipWriter.CreateHeader(&header)
			if err != nil {
				log.Print("Failed to create header")
				return err
			}
			fileReader, err := os.Open(path)
			if err != nil {
				log.Print("Failed to create reader")
				return err
			}
			_, err = io.Copy(zipFileWriter, fileReader)
			if err != nil {
				log.Print(err)
				return nil
			}
			return nil
		})

	zipWriter.Close()
	return buffer, nil
}

// GetLevelManifest returns the manifest of the level.
func GetLevelManifest(levelID string) ([]byte, error) {
	return ioutil.ReadFile(levelID + "manifest.json")
}
