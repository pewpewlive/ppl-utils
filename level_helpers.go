package main

import (
	"archive/zip"
	"bytes"
	"encoding/json"
	"errors"
	"io"
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
	AuthorAccountID string `json:"account_id"`
	LevelUUID       string `json:"level_uuid"`
	Date            int64  `json:"date"`
	PublishState    int    `json:"publish_state"`
	Experimental    bool   `json:"experimental"`
	LeaderboardKind int    `json:"leaderboard_kind"`
	Version         int    `json:"v"`
	Difficulty      int    `json:"diff"`
	Featured        bool   `json:"featured"`
}

// LevelManifest stores the manifest of a level.
type LevelManifest struct {
	Name                string `json:"name"`
	Description         string `json:"description"`
	EntryPoint          string `json:"entry_point"`
	HasScoreLeaderboard bool   `json:"has_score_leaderboard"`
}

// GetDir returns the path to the levels directory.
func GetDir() string {
	cwd, err := os.Getwd()
	if err != nil {
		panic(err)
	}

	dir, err := filepath.Abs(cwd)
	if err != nil {
		panic(err)
	}
	dir = dir + string(os.PathSeparator) + "levels"
	return dir
}

// ListLevels lists the levels.
// A level is a subdirectory that contains a properly formatted json file.
func ListLevels(dir string) []LevelJSON {
	levels := []LevelJSON{}

	err := filepath.Walk(dir,
		func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}

			// Check if the file is a symlink.
			file_info, stat_err := os.Lstat(path)
			if stat_err != nil {
				log.Print("Failed to os.Lstat")
				return stat_err
			}

			// log.Print("path: " + path + ", file_info.Mode():" + file_info.Mode().String())

			fileIsASymLink := file_info.Mode()&os.ModeSymlink != 0
			// If the file is a symlink, recursively walk it.
			// TODO: prevent infinite loops.
			if fileIsASymLink {
				link, read_link_err := os.Readlink(path)
				if read_link_err != nil {
					log.Print("Failed to os.ReadLink")
					return read_link_err
				}
				log.Print("followed sym link to " + link)
				sub_levels := ListLevels(link)
				levels = append(levels, sub_levels...)
				return nil
			}

			directory, filename := filepath.Split(path)

			if filename != "manifest.json" {
				return nil
			}

			jsonContent, err := os.ReadFile(path)
			if err != nil {
				log.Print("Failed to read file at path " + path)
				return nil
			}
			levelManifest := &LevelManifest{}
			err = json.Unmarshal(jsonContent, levelManifest)
			if err != nil {
				log.Print("Failed to parse " + path)
				log.Print("Error: " + err.Error())
				// Do not return an error, otherwise a single malformed manifest
				// will prevent the parsing of all the other manifests.
				return nil
			}

			directory = strings.ReplaceAll(directory, string(os.PathSeparator), "/")
			level := LevelJSON{
				Name:            levelManifest.Name,
				Author:          "Anonymous",
				LevelUUID:       directory,
				Date:            0,
				Experimental:    true,
				PublishState:    0,
				LeaderboardKind: 0,
				Version:         0,
			}
			if levelManifest.HasScoreLeaderboard {
				level.LeaderboardKind = 1
			}
			levels = append(levels, level)
			return nil
		})
	if err != nil {
		log.Print("Failed to list levels: " + err.Error())
	}
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
func GetLevelData(levelID string, disableFilter bool) (bytes.Buffer, error) {
	var buffer bytes.Buffer
	if !canRead(levelID) {
		return buffer, errors.New("Can't read path")
	}
	zipWriter := zip.NewWriter(&buffer)
	defer zipWriter.Close()

	err := filepath.Walk(levelID,
		func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return nil
			}
			if !disableFilter && filepath.Ext(path) != ".lua" {
				return nil
			}
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
			defer fileReader.Close()
			_, err = io.Copy(zipFileWriter, fileReader)
			if err != nil {
				log.Print("Failed to copy file:" + err.Error())
				return err
			}
			return nil
		})
	if err != nil {
		return buffer, err
	}

	// Tells `zipWriter` to finish writing the zip into `buffer`.
	zipWriter.Close()
	return buffer, nil
}

// here `levelId` corresponds to the on-disk path of the level, for example:
// /Users/JF/foo/bar/qux/ppl-utils/levels/sample_advanced_level/"
func GetLevelManifestWithExtraInfo(levelId string) (bytes.Buffer, error) {
	var buffer bytes.Buffer

	manifest, manifestErr := os.ReadFile(levelId + "manifest.json")
	if manifestErr != nil {
		return buffer, manifestErr
	}

	buffer.WriteString("{\"manifest\":")
	buffer.Write(manifest)
	buffer.WriteString(",\"extra\":{\"name\":\"...\",\"author\":\"Anonymous\",\"account_id\":\"\", \"level_uuid\":\"irrelevant\", \"v\":0, \"date\":0, \"publish_state\":0, \"experimental\":true, \"leaderboard_kind\":0, \"diff\":0, \"featured\":false}}")
	return buffer, nil
}
