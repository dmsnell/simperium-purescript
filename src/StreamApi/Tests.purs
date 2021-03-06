module StreamApi.Tests (testStreamApi) where

import Control.Monad.Aff (Aff)
import Data.Array (replicate)
import Data.String (fromCharArray)
import Prelude (Unit, bind, negate, ($))
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

import Types.AppId (isValidAppId)
import Types.BucketName (isValidBucketName)
import Types.EmailAddress (isValidEmailAddress)
import Types.EntityVersion (isValidEntityVersion)
import Types.Key (isValidKey)

tester :: forall a e. (a -> Boolean) -> Boolean -> a -> Aff (e) Unit
tester predicate result thing = predicate thing `shouldEqual` result

testStreamApi :: forall r. Spec r Unit
testStreamApi =
    describe "Base Types" do
        testAppId
        testBucketName
        testEmailAddress
        testEntityVersion
        testKey

testAppId :: forall r. Spec r Unit
testAppId =
    describe "AppId" do
        it "should reject invalid names" do
            let fail = tester isValidAppId false

            fail "#"
            fail "$"
            fail ""
            fail $ fromCharArray $ replicate 257 'a'

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

testEmailAddress :: forall r. Spec r Unit
testEmailAddress =
  describe "EmailAddress" do
    let fail = tester isValidEmailAddress false
    let pass = tester isValidEmailAddress true

    it "should require an @" do
      fail "testEmail"

    it "should reject strings with spaces" do
      fail "test @example.com"
      fail " test@example.com"
      fail " "

    it "should reject local domains" do
      fail "test@localhost"
      fail "test@example"

    it "should allow trivial emails" do
      pass "test@example.com"
      pass "test.email@example.com"

    it "should allow plus-addressing" do
      pass "test+filter@example.com"

    it "should allow subdomains" do
      pass "test@test.example.com"

testEntityVersion :: forall r. Spec r Unit
testEntityVersion =
  describe "EntityVersion" do
    it "should reject negative version numbers" do
      (isValidEntityVersion (-1)) `shouldEqual` false

    it "should allow non-negative version numbers" do
      (isValidEntityVersion 0) `shouldEqual` true
      (isValidEntityVersion 1) `shouldEqual` true

testKey :: forall r. Spec r Unit
testKey =
  describe "Key" do
    it "should reject invalid keys" do
      let fail = tester isValidKey false

      fail "#"
      fail ""
      fail " "
      fail "\t"
      fail $ fromCharArray $ replicate 257 'a'

    it "should allow valid keys" do
      let pass = tester isValidKey true

      pass "."
      pass "@"
      pass "_.-"
      pass "abc123"
      pass $ fromCharArray $ replicate 256 'a'
