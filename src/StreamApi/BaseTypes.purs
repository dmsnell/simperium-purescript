module StreamApi.BaseTypes
    ( AccessToken
    , ApiVersion
    , AppId
    , BucketName
    , ClientId
    , LibraryName
    , LibraryVersion
    , appId
    , bucketName
    , isValidBucketName
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

appId :: String -> Maybe AppId
appId s = map AppId (validateString "^[a-zA-Z0-9._-]{1,256}$" s)

instance appIdEq :: Eq AppId where
    eq (AppId a) (AppId b) = eq a b

instance appIdShow :: Show AppId where
    show (AppId a) = show a

bucketName :: String -> Maybe BucketName
bucketName s = map BucketName (validateString "^[a-zA-Z0-9._%-]{1,64}$" s)

isValidBucketName :: String -> Boolean
isValidBucketName = isJust <<< bucketName

instance bucketNameEq :: Eq BucketName where
    eq (BucketName a) (BucketName b) = eq a b

instance bucketNameShow :: Show BucketName where
    show (BucketName a) = show a

instance apiVersionEq :: Eq ApiVersion where
    eq (ApiVersion a) (ApiVersion b) = a == b

instance apiVersionOrd :: Ord ApiVersion where
    compare (ApiVersion a) (ApiVersion b) = compare a b

thisApiVersion :: ApiVersion
thisApiVersion = ApiVersion "1.1"

thisClientId :: ClientId
thisClientId = ClientId "simperium-purescript-0.1.0"
