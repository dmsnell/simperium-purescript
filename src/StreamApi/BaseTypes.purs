module StreamApi.BaseTypes where

import Prelude
import Data.Either (either)
import Data.Maybe (Maybe(Just, Nothing))
import Data.String.Regex (Regex, regex, test)
import Data.String.Regex.Flags (noFlags)

newtype AccessToken = AccesToken String
newtype ApiVersion = ApiVersion String
newtype AppId = AppId String
newtype BucketName = BucketName String
newtype ClientId = ClientId String
newtype LibraryName = LibraryName String
newtype LibraryVersion = LibraryVersion String

validateString :: String -> String -> Maybe String
validateString pattern input =
    let 
        regExp = regex pattern noFlags
    in
        either (const Nothing) validateAppId regExp
            where
                validateAppId :: Regex -> Maybe String
                validateAppId matcher =
                    case test matcher input of
                        true -> Just input
                        false -> Nothing

appId :: String -> Maybe AppId
appId s = map AppId (validateString "^[a-zA-Z0-9._-]{1,256}$" s)

instance appIdEq :: Eq AppId where
    eq (AppId a) (AppId b) = eq a b

instance appIdShow :: Show AppId where
    show (AppId a) = show a

bucketName :: String -> Maybe BucketName
bucketName s = map BucketName (validateString "^[a-zA-Z0-9._%-]{1,64}$" s)

instance bucketNameEq :: Eq BucketName where
    eq (BucketName a) (BucketName b) = eq a b

instance bucketNameShow :: Show BucketName where
    show (BucketName a) = show a

thisApiVersion :: ApiVersion
thisApiVersion = ApiVersion "1.1"

thisClientId :: ClientId
thisClientId = ClientId "simperium-purescript-0.1.0"

