module StreamApi.BaseTypes
    ( AccessToken
    , ApiVersion
    , ClientId
    , LibraryName
    , LibraryVersion
    , thisApiVersion
    , thisClientId
    ) where

import Prelude

newtype AccessToken = AccesToken String
newtype ApiVersion = ApiVersion String
newtype ClientId = ClientId String
newtype LibraryName = LibraryName String
newtype LibraryVersion = LibraryVersion String

instance apiVersionEq :: Eq ApiVersion where
    eq (ApiVersion a) (ApiVersion b) = a == b

instance apiVersionOrd :: Ord ApiVersion where
    compare (ApiVersion a) (ApiVersion b) = compare a b

thisApiVersion :: ApiVersion
thisApiVersion = ApiVersion "1.1"

thisClientId :: ClientId
thisClientId = ClientId "simperium-purescript-0.1.0"
