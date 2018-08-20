{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds                 #-}
{-# LANGUAGE DefaultSignatures         #-}
{-# LANGUAGE DeriveGeneric             #-}
{-# LANGUAGE EmptyCase                 #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE KindSignatures            #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE ScopedTypeVariables       #-}
{-# LANGUAGE StandaloneDeriving        #-}
{-# LANGUAGE Trustworthy               #-}
{-# LANGUAGE TypeFamilies              #-}
{-# LANGUAGE TypeOperators             #-}
{-# LANGUAGE TypeSynonymInstances      #-}
{-# LANGUAGE UndecidableInstances      #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}

module Enqm.API.RPC.Instances where

import Enqm.API.RPC
import GHC.Generics
import Data.Typeable
import GHC.TypeLits ( Nat, Symbol, KnownSymbol, KnownNat, symbolVal, natVal )
import Generics.Instant.TH

instance Show ApiRpcMethods where
  show = test

class Test f where
  cnm :: f a -> String

data Kuku
  = Kuku { n220 :: Int, v :: Double }
  | CDSc { cdcd :: Integer, cdwcd :: String }
  | DDDD Int
 deriving (Generic)

data Test01 a where
  QQQQQ  :: Int -> Test01 ()
  DDDDDD :: Double -> Int -> Test01 Int
  BAASD  :: Double -> Int -> Test01 Int
$(deriveAll ''Test01)


instance Test V1 where cnm _  = "V1"
instance Test U1 where cnm U1 = "U1"

instance (Test f, Test g) => Test (f :+: g) where
  cnm (L1 x) = cnm x
  cnm (R1 x) = cnm x
  
instance (Test f, Test g) => Test (f :*: g) where
  cnm (x :*: y) = "(" ++ cnm x ++ ":*:" ++ cnm y ++ ")"

instance (Typeable c) => Test (K1 R c) where
  cnm _ = "(" ++ (show $ typeOf (undefined :: c)) ++ ")"

instance {-# OVERLAPPABLE #-} (Test f)  => Test (M1 i t f) where
  cnm a = cnm (unM1 a)

instance {-# OVERLAPPING #-} (Test f, KnownSymbol a)  => Test (M1 i ('MetaCons a b c) f) where
  cnm a = symbolVal (Proxy :: Proxy a) ++ " " ++ (cnm $ unM1 a)

instance {-# OVERLAPPING #-} (Test f, KnownSymbol a)  => Test (M1 i ('MetaSel ('Just a) b c d) f) where
  cnm a = symbolVal (Proxy :: Proxy a) ++ " " ++ (cnm $ unM1 a)

instance {-# OVERLAPPING #-} (Test f)  => Test (M1 i ('MetaSel ('Nothing) b c d) f) where
  cnm a = "field " ++ (cnm $ unM1 a)


test :: (Test (Rep a), Generic a) => a -> String
test a = cnm (from a)



