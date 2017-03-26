module Types.BucketName
    ( BucketName
    , bucketName
    , isValidBucketName
    ) where

import Prelude (class Eq, class Show, eq, map, show, (<<<))
import Data.Maybe (Maybe, isJust)

import Types.RegexValidator (validateString)

newtype BucketName = BucketName String

bucketName :: String -> Maybe BucketName
bucketName = (map BucketName) <<< (validateString "^[a-zA-Z0-9._%-]{1,64}$")

isValidBucketName :: String -> Boolean
isValidBucketName = isJust <<< bucketName

instance eqBucketName :: Eq BucketName where
    eq (BucketName a) (BucketName b) = eq a b

instance showBucketName :: Show BucketName where
    show (BucketName a) = show a
