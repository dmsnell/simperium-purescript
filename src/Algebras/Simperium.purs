module Algebras.Simperium where

import Control.Monad.Free (Free, liftF)
import Data.Either (Either)
import Types.BucketName (BucketName)
import Types.ConnectionInfo (ConnectionInfo)
import Types.EmailAddress (EmailAddress)
import Types.Entity (Entity)
import Types.EntityVersion (EntityVersion)
import Types.Key (Key)

import Prelude (id)

data ConnectionError
  = TokenFormatInvalid
  | TokenInvalid
  | UnspecifiedError

data RequestError = EntityNotFound

class Simperium f where
  connectToBucket :: ConnectionInfo -> BucketName -> f (Either ConnectionError EmailAddress)
  requestEntity :: Key -> EntityVersion -> f (Either RequestError Entity)

data SimperiumF a
  = ConnectToBucket ConnectionInfo BucketName (Either ConnectionError EmailAddress -> a)
  | RequestEntity Key EntityVersion (Either RequestError Entity -> a)

instance simperiumSimperiumF :: Simperium SimperiumF where
  connectToBucket c n = ConnectToBucket c n id
  requestEntity k v = RequestEntity k v id

instance simperiumFree :: (Simperium f) => Simperium (Free f) where
  connectToBucket c n = liftF connectToBucket
  requestEntity k v = liftF (requestEntity k v)
