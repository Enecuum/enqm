module Enqm.API.RPC.Generic where

import Language.Haskell.TH
import Text.Regex.Posix
import Data.List
import Data.Dynamic
import Data.Typeable
import Data.Char
import Language.Haskell.Meta.Parse

extractAllFunctions :: String -> Q [String]
extractAllFunctions pattern =
  do loc <- location
     file <- runIO $ readFile $ loc_filename loc
     return $ nub $ map fst $ filter (\(a,b) -> (a++b)=~pattern) $ concat $ map lex $ lines file

functionExtractor :: String -> ExpQ
functionExtractor pattern =
  do functions <- extractAllFunctions pattern
     {-
     (Name "ApiRpcFunctions" NameS) [] Nothing conq
     -}
     let makePair n = TupE [ LitE $ StringL n , (VarE $ mkName "typeOf") `AppE` (VarE $ mkName n)]
     return $ ListE $ map makePair functions

createAndAssignData :: String -> [(String, TypeRep)] -> DecsQ
createAndAssignData (n:ns) tab0 = return [dat]
 where
  tab1 = map (\(a,b) -> (a,parseType $ show b)) tab0
  con = map (\(x:xs,Right t) -> NormalC (mkName (toUpper x:xs)) [(Bang NoSourceUnpackedness NoSourceStrictness,t)]) tab1
  dat = DataD [] (mkName (toUpper n:ns)) [] Nothing con []

