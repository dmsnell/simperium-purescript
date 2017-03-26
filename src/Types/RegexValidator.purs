module Types.RegexValidator 
    ( validateString
    ) where

import Prelude (const, ($))
import Data.Either (either)
import Data.Maybe (Maybe(Just, Nothing))
import Data.String.Regex (regex, test)
import Data.String.Regex.Flags (noFlags)

validateString :: String -> String -> Maybe String
validateString pattern input = 
    either default toJust regExp
        where
            regExp = regex pattern noFlags
            toJust matcher = toMaybe input $ test matcher input

default = const Nothing

toMaybe :: String -> Boolean -> Maybe String
toMaybe input true = Just input
toMaybe _ false = Nothing