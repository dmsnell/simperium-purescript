module Types.EntityVersion
  ( EntityVersion
  , entityVersion
  , isValidEntityVersion
  ) where

import Prelude (class Eq, class Ord, class Show, compare, map, show, (==), (>=), (<<<))
import Data.Maybe (Maybe(Just, Nothing), isJust)

newtype EntityVersion = EntityVersion Int

entityVersion :: Int -> Maybe EntityVersion
entityVersion n = map EntityVersion maybeVersion
  where
    maybeVersion = if n >= 0 then Just n else Nothing

isValidEntityVersion :: Int -> Boolean
isValidEntityVersion = isJust <<< entityVersion

instance eqEntityVersion :: Eq EntityVersion where
  eq (EntityVersion a) (EntityVersion b) = a == b

instance ordEntityVersion :: Ord EntityVersion where
  compare (EntityVersion a) (EntityVersion b) = compare a b

instance showEntityVersion :: Show EntityVersion where
  show (EntityVersion a) = show a
