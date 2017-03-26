module Types.AppId
    ( AppId
    , appId
    , isValidAppId
    ) where

import Prelude (class Eq, class Show, eq, map, show, (<<<))
import Data.Maybe (Maybe, isJust)

import Types.RegexValidator (validateString)

newtype AppId = AppId String

appId :: String -> Maybe AppId
appId s = map AppId (validateString "^[a-zA-Z0-9._-]{1,256}$" s)

isValidAppId :: String -> Boolean
isValidAppId = isJust <<< appId

instance eqAppId :: Eq AppId where
    eq (AppId a) (AppId b) = eq a b

instance showAppId :: Show AppId where
    show (AppId a) = show a
