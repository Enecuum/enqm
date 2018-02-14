{-# LANGUAGE QuasiQuotes #-}

module Enqm.API.UnixShell.Generated where

import Enqm.API.Methods
import Text.RawString.QQ
import System.Directory

dir = "Enqm/API/UnixShell/Generated"

generate = do
  True <- doesDirectoryExist "Enqm/API/UnixShell/Generated"
  mapM_ (genFile.fst) $ _Enqin ++ _Access

genFile method = do
  writeFile (dir ++ "/" ++ method ++ ".hs") source

source = [r|

import System.Environment

main = do
  args <- getArgs
  print args


|]

