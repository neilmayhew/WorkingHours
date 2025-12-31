{-# LANGUAGE ApplicativeDo #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ViewPatterns #-}

import Data.Time
import Options.Applicative

import qualified System.Console.Terminal.Size as TS

data Options = Options
  { optStart :: Day
  , optEnd :: Day
  } deriving (Show)

main :: IO ()
main = do

  today <- localDay . zonedTimeToLocalTime <$> getZonedTime

  let thisYear = fromGregorian (yearOfDay today) 1 1
      yearOfDay (toGregorian -> (y, _, _)) = y

  cols <- maybe 100 TS.width <$> TS.size

  Options {..} <- customExecParser
    ( prefs $ columns cols )
    ( info
      ( helper <*> do
          optStart <- option auto $
            short 's' <> long "start" <>
            metavar "DATE" <> value thisYear <>
            help "The start of the period" <> showDefault
          optEnd <- option auto $
            short 'e' <> long "end" <>
            metavar "DATE" <> value today <>
            help "The end of the period" <> showDefault
          pure Options{..}
      )
      ( fullDesc <> header "Compute the number of working hours in a given period" )
    )

  print $ (8 *) . length $ filter ((Friday >=) . dayOfWeek) [optStart .. optEnd]
