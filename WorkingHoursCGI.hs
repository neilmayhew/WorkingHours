{-# LANGUAGE ViewPatterns #-}

import Control.Exception (ErrorCall (..))
import Control.Monad.Catch (MonadCatch, throwM)
import Data.List ((\\))
import Data.Time
import Network.CGI
import Text.Read (readMaybe)

main :: IO ()
main = runCGI (handleErrors cgiMain)

cgiMain :: CGI CGIResult
cgiMain = do

  today <- liftIO $ localDay . zonedTimeToLocalTime <$> getZonedTime

  let thisYear = fromGregorian (yearOfDay today) 1 1
      yearOfDay (toGregorian -> (y, _, _)) = y

  startDate <- readInputDefault thisYear =<< getInput "start"
  endDate <- readInputDefault today =<< getInput "end"

  unusedInputs <- (\\ ["start", "end"]) <$> getInputNames

  if not (null unusedInputs)
    then
      outputError 400 "Bad Request" $ "Unrecognized inputs:" : unusedInputs
    else
      output $ show . (8 *) . length $ filter ((Friday >=) . dayOfWeek) [startDate .. endDate]

readInputDefault :: (Read a, MonadCatch m, MonadCGI m) => a -> Maybe String -> m a
readInputDefault a Nothing = pure a
readInputDefault _ (Just s) = maybe (throwM . ErrorCall $ "Cannot read " <> s) pure $ readMaybe s
