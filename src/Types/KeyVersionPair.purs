module Types.KeyVersionPair
  ( KeyVersionPair
  ) where

import Types.EntityVersion (EntityVersion)
import Types.Key (Key)

data KeyVersionPair = KeyVersionPair Key EntityVersion
