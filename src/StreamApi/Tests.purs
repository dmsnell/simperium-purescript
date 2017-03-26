module StreamApi.Tests (testStreamApi) where

import Control.Monad.Aff (Aff)
import Data.Array (replicate)
import Data.String (fromCharArray)
import Prelude (Unit, bind, ($))
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

import Types.AppId (isValidAppId)
import Types.BucketName (isValidBucketName)

tester :: forall a e. (a -> Boolean) -> Boolean -> a -> Aff (e) Unit
tester predicate result thing = predicate thing `shouldEqual` result

testStreamApi :: forall r. Spec r Unit
testStreamApi = 
    describe "Base Types" do
        testAppId
        testBucketName

testAppId :: forall r. Spec r Unit
testAppId = 
    describe "AppId" do
        it "should reject invalid names" do
            let fail = tester isValidAppId false

            fail "#"
            fail "$"
            fail ""
            fail $ fromCharArray $ replicate 300 'a'

        it "should allow valid names" do
            let pass = tester isValidAppId true

            pass "test"
            pass "abc123"
            pass "_.-"

testBucketName :: forall r. Spec r Unit
testBucketName =
    describe "BucketName" do
        it "should reject invalid names" do
            let fail = tester isValidBucketName false
            
            fail "#"
            fail ""
            fail $ fromCharArray $ replicate 65 'a'
        
        it "should allow valid names" do
            let pass = tester isValidBucketName true

            pass "test"
            pass "abc123"
            pass "_.-"

