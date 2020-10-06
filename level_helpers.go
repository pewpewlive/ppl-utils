package main

import (
	"archive/zip"
	"bytes"
	"encoding/json"
	"io"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"
	"time"
)

type LevelOnDisk struct {
	name      string
	author    string
	directory string
}

type LevelJSON struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	EntryPoint  string `json:"entry_point"`
}

func GetDir() string {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		log.Fatal(err)
	}
	dir = dir + string(os.PathSeparator) + "content"
	return dir
}

// A level is a subdirectory that contains a properly formatted json file.
func ListLevels() []LevelOnDisk {
	levels := []LevelOnDisk{}

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

			levelJSON := &LevelJSON{}
			err = json.Unmarshal(jsonContent, levelJSON)
			if err != nil {
				return err
			}

			level := new(LevelOnDisk)
			level.directory = directory
			level.name = levelJSON.Name
			level.author = "TBD"
			levels = append(levels, *level)
			return nil
		})

	return levels
}

func canRead(path string) bool {
	_, err := os.Stat(path)
	if err == nil {
		return true
	} else {
		return false
	}
}

// http://localhost:9000/custom_levels/get_level?level_id=/Users/jif/Code/ppl-utils/content/dynamic/levels/simple_level/

// levelId is the path to the directory containing the level.
func GetLevelData(levelId string) bytes.Buffer {
	var buffer bytes.Buffer
	if !canRead(levelId) {
		return buffer
	}
	zipWriter := zip.NewWriter(&buffer)
	defer zipWriter.Close()

	filepath.Walk(levelId,
		func(path string, info os.FileInfo, err error) error {
			log.Print(path)
			var header zip.FileHeader
			header.Name = "level/" + strings.TrimPrefix(path, levelId)
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
	return buffer
}
