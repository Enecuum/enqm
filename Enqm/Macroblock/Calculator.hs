{-# LANGUAGE DuplicateRecordFields, GADTs #-}

module Enqm.Macroblock.Calculator where

import System.Random

data Linked
data Template
data Published

type SizeInBytes            = Integer
type GapInMilliseconds      = Integer
type LifeTimeInMilliseconds = Integer

type UniformFromZeroToOne = Double
type ProbFunU a = UniformFromZeroToOne -> a

type PointAtTime = Integer                                                -- Milliseconds
type Cursor      = (PointAtTime,[MacroBlock])
data Link        = Link { macroblockId :: Int, blockNumber :: Int }

data MacroBlock = MacroBlock { macroblockId :: Int, sequenceOfBlocks :: [Block Published] }

data Block a where
  Published  :: PointAtTime -> Block Linked   -> Block Published
  Linked     :: [Link]      -> Block Template -> Block Linked
  BytesUsed  :: Int         -> Block Template -> Block Template
  AnyBlock   ::                                  Block Template

data MacroblockGenerator = MG
  { blockMinSize                               ::          SizeInBytes
  , blockMaxSize                               ::          SizeInBytes
  , probabilityFunctionForBlockSize            :: ProbFunU SizeInBytes
  , blockMinGapTime                            ::          GapInMilliseconds
  , blockMaxGapTime                            ::          GapInMilliseconds
  , probabilityFunctionForGapTimeBetweenBlocks :: ProbFunU GapInMilliseconds
  , macroblockMinSize                          ::          SizeInBytes
  , macroblockMaxSize                          ::          SizeInBytes
  , probabilifyFunctionForMacroblockSize       :: ProbFunU SizeInBytes
  , macroblockMinLifeTime                      ::          LifeTimeInMilliseconds
  , macroblockMaxLifeTime                      ::          LifeTimeInMilliseconds
  , probabilityFunctionForMacroblockLifeTime   :: ProbFunU LifeTimeInMilliseconds
  }


{-
getRandom = do
  a <- randomRIO (0,2^16)
  b <- unsafeInterleaveIO $ getRandom s
  return (a:b)

integ (a:b:c) = (a+b) : integ (b:c)
integ _ = []

getRandomPublications = do
rnd <- getRandom
let times = integ rnd
return times
-}


