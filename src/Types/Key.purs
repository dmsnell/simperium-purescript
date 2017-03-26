module Types.Key
  ( Key
  , isValidKey
  , key
  ) where

import Prelude (class Eq, class Show, map, show, (==), (<<<))
import Data.Maybe (Maybe, isJust)

import Types.RegexValidator (validateString)

newtype Key = Key String

key :: String -> Maybe Key
key = (map Key) <<< (validateString "^[a-zA-Z0-9._%@-]{1,256}$")

isValidKey :: String -> Boolean
isValidKey = isJust <<< key

instance eqKey :: Eq Key where
  eq (Key a) (Key b) = a == b

instance showKey :: Show Key where
  show (Key s) = show s
