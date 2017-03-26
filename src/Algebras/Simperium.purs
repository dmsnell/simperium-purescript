module Algebras.Simperium where

import Data.Either (Either)
import Types.BucketName (BucketName)
import Types.ConnectionInfo (ConnectionInfo)
import Types.EmailAddress (EmailAddress)
import Types.Entity (Entity)
import Types.EntityVersion (EntityVersion)
import Types.Key (Key)

data ConnectionError
  = TokenFormatInvalid
  | TokenInvalid
  | UnspecifiedError

data RequestError = EntityNotFound

class Simperium f where
  connectToBucket :: ConnectionInfo -> BucketName -> f Either ConnectionError EmailAddress
  requestEntity :: Key -> EntityVersion -> f Either RequestError Entity
