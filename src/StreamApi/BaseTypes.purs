module StreamApi.BaseTypes
    ( AccessToken
    , ClientId
    , LibraryName
    , LibraryVersion
    , thisClientId
    ) where

import Prelude

newtype AccessToken = AccesToken String
newtype ClientId = ClientId String
newtype LibraryName = LibraryName String
newtype LibraryVersion = LibraryVersion String

thisClientId :: ClientId
thisClientId = ClientId "simperium-purescript-0.1.0"
