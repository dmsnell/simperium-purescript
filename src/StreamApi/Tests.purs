module StreamApi.Tests (testStreamApi) where

import Prelude (Unit, bind, ($))
import Data.Array (replicate)
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
            appId "test" `shouldEqual` Just (AppId "test")
            appId "abc123" `shouldEqual` Just (AppId "abc123")
            appId "_.-" `shouldEqual` Just (AppId "_.-")

testBucketName :: forall r. Spec r Unit
testBucketName =
    describe "BucketName" do
        it "should reject invalid names" do
            bucketName "#" `shouldEqual` Nothing
            bucketName "" `shouldEqual` Nothing
            bucketName (fromCharArray $ replicate 65 'a') `shouldEqual` Nothing
        
        it "should allow valid names" do
            bucketName "test" `shouldEqual` Just (BucketName "test")
            bucketName "abc123" `shouldEqual` Just (BucketName "abc123")
            bucketName "_.-%" `shouldEqual` Just (BucketName "_.-%")