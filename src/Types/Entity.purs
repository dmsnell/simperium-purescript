module Types.Entity
  ( Entity
  ) where

import Data.Argonaut.Core (Json)

import Types.EntityVersion (EntityVersion)
import Types.Key (Key)

data Entity = Entity Key EntityVersion Json
