{-# LANGUAGE TypeApplications #-}

module Enqm.API.RPC.Generic where

import Language.Haskell.TH
import Text.Regex.Posix
import Data.List
import Data.Dynamic
import Data.Typeable
import Data.Char
import Language.Haskell.Meta.Parse
import Data.Typeable

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
createAndAssignData name@(n:ns) tab0 = return [dat,fun]
 where
  mkUpper (x:xs) = mkName (toUpper x:xs)
  tab1 = map (\(a,b) -> (a,parseType $ show b)) tab0
  con = map (\(name@(x:xs),Right t) -> NormalC (mkUpper name) [(Bang NoSourceUnpackedness NoSourceStrictness,t)]) tab1
  dat = DataD [] (mkName (toUpper n:ns)) [] Nothing con [DerivClause Nothing [ConT (mkName "Generic")]]
  fun = FunD (mkName name) [Clause [] (NormalB $ ListE list) []]
   where
    list = map (\name@(x:xs) -> ConE (mkUpper name) `AppE` (VarE $ mkName name)) $ map fst tab0
  -- inst01 = InstanceD Notihig [] (ConT (mkName "Show") `AppT` (VarT (mkName "a"))) [FunD (mkName "show") 

