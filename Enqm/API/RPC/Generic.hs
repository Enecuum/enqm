module Enqm.API.RPC.Generic where

import Language.Haskell.TH
import Text.Regex.Posix
import Data.List
import Data.Dynamic

extractAllFunctions :: String -> Q [String]
extractAllFunctions pattern =
  do loc <- location
     file <- runIO $ readFile $ loc_filename loc
     return $ nub $ map fst $ filter (\(a,b) -> (a++b)=~pattern) $ concat $ map lex $ lines file

functionExtractor :: String -> ExpQ
functionExtractor pattern =
  do functions <- extractAllFunctions pattern
     {-
     let conq = map (\x:xs -> Q $ NormalC (toUpper x:xs) [(Bang NoSourceUnpackedness NoSourceStrictness,)]) functions
     (Name "ApiRpcFunctions" NameS) [] Nothing conq
     -}
     let makePair n = TupE [ LitE $ StringL n , (VarE $ mkName "typeOf") `AppE` (VarE $ mkName n)]
     return $ ListE $ map makePair functions

