module StreamApi.Tests (testStreamApi) where

import Prelude (Unit, bind, show, ($))
import Data.Array (replicate)
import Data.Functor (map)
import Data.Maybe (Maybe(Just, Nothing))
import Data.String (fromCharArray)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

import StreamApi.BaseTypes

testStreamApi :: forall r. Spec r Unit
testStreamApi = 
    describe "Base Types" do
        testAppId
        testBucketName

testAppId :: forall r. Spec r Unit
testAppId = 
    describe "AppId" do
        it "should reject invalid names" do
            appId "#" `shouldEqual` Nothing
            appId "$" `shouldEqual` Nothing
            appId "" `shouldEqual` Nothing
            appId (fromCharArray $ replicate 300 'a') `shouldEqual` Nothing

        it "should allow valid names" do
            (show $ appId "test") `shouldEqual` (show (Just "test"))
            (show $ appId "abc123") `shouldEqual` (show (Just "abc123"))
            (show $ appId "_.-") `shouldEqual` (show (Just "_.-"))

testBucketName :: forall r. Spec r Unit
testBucketName =
    describe "BucketName" do
        it "should reject invalid names" do
            isValidBucketName "#" `shouldEqual` false
            isValidBucketName "" `shouldEqual` false
            isValidBucketName (fromCharArray $ replicate 65 'a') `shouldEqual` false
        
        it "should allow valid names" do
            isValidBucketName "test" `shouldEqual` true
            isValidBucketName "abc123" `shouldEqual` true
            isValidBucketName "_.-%" `shouldEqual` true