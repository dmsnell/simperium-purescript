module Simperium.RequestEntity where

import Data.Inject (Inject)

import Algebras.Simperium
import Types.Entity (Entity)
import Types.EntityVersion (EntityVersion)
import Types.Key (Key)

requestEntity
  :: forall f. (Inject SimperiumF f)
  -> Key
  -> EntityVersion
  => Free f (Either RequestError Entity)
requestEntity key version = do
  entity <- getEntity key version
  return if isJust entity then Right entity else Left EntityNotFound
