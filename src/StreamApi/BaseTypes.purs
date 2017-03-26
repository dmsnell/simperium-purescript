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
import Data.Maybe (Maybe, isJust)

import Types.RegexValidator (validateString)

newtype AccessToken = AccesToken String
newtype ApiVersion = ApiVersion String
newtype AppId = AppId String
newtype BucketName = BucketName String
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
