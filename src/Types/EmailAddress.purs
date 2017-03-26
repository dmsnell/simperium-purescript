module Types.EmailAddress
  ( EmailAddress
  , emailAddress
  , isValidEmailAddress
  ) where

import Prelude (map, (<<<))
import Data.Maybe (Maybe, isJust)

import Types.RegexValidator (validateString)

newtype EmailAddress = EmailAddress String

{-
This only performs a very basic check for validity
of an email address. It doesn't attempt to conform
to any specification and it's intented to be more
limited than email RFCs permit. We not only need a
valid email address but we also need an address we
can actually reach.
-}
emailAddress :: String -> Maybe EmailAddress
emailAddress = (map EmailAddress) <<< (validateString "^[^\\s]+@[^\\s]+\\.[^.\\s]+$")

isValidEmailAddress :: String -> Boolean
isValidEmailAddress = isJust <<< emailAddress
