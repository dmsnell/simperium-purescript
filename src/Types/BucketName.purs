module Types.BucketName
    ( BucketName
    , bucketName
    , isValidBucketName
    ) where

import Prelude (class Eq, class Show, eq, map, show, (<<<))
import Data.Maybe (Maybe, isJust)

import Types.RegexValidator (validateString)

data BucketName = BucketName String

bucketName :: String -> Maybe BucketName
bucketName s = map BucketName (validateString "^[a-zA-Z0-9._%-]{1,64}$" s)

isValidBucketName :: String -> Boolean
isValidBucketName = isJust <<< bucketName

instance bucketNameEq :: Eq BucketName where
    eq (BucketName a) (BucketName b) = eq a b

instance bucketNameShow :: Show BucketName where
    show (BucketName a) = show a
