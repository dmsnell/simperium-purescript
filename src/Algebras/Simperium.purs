module Algebras.Simperium where

import Data.Either (Either)

import Types.Entity (Entity)
import Types.EntityVersion (EntityVersion)
import Types.Key (Key)

data RequestError = EntityNotFound

class Simperium f where
  requestEntity :: Key -> EntityVersion -> f Either RequestError Entity
