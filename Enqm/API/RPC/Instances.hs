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

module Enqm.API.RPC.Instances where

import Enqm.API.RPC
import GHC.Generics
import Data.Typeable
import GHC.TypeLits ( Nat, Symbol, KnownSymbol, KnownNat, symbolVal, natVal )

instance Show ApiRpcMethods where
  show = test

class Test f where
  cnm :: f a -> String

instance Test V1 where cnm _  = "V1"
instance Test U1 where cnm U1 = "U1"

instance (Test f, Test g) => Test (f :+: g) where
  cnm (L1 x) = cnm x
  cnm (R1 x) = cnm x
  
instance (Test f, Test g) => Test (f :*: g) where
  cnm (x :*: y) = ":*:"

instance Test (K1 i c) where
  cnm (K1 x) = "K1"

instance {-# OVERLAPPABLE #-} (Test f)  => Test (M1 i t f) where
  cnm = cnm . unM1

instance {-# OVERLAPPING #-} (Test f,KnownSymbol a)  => Test (M1 i ('MetaCons a b c) f) where
  cnm a = symbolVal (Proxy :: Proxy a) ++ " " ++ (cnm $ unM1 a)


test :: (Test (Rep a), Generic a) => a -> String
test a = cnm (from a)



