module StreamApi.BaseTypes
    ( AccessToken
    , LibraryName
    , LibraryVersion
    ) where

import Prelude

newtype AccessToken = AccesToken String
newtype LibraryName = LibraryName String
newtype LibraryVersion = LibraryVersion String
