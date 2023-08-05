module Main (main) where

import Data.List (intercalate)

maxWidths :: [String] -> [[String]] -> [Int]
maxWidths header = foldr (zipWith max . lengths) (lengths header)
 where
  lengths = map length

renderSeparator :: [Int] -> String
renderSeparator widths =
  let pieces = map (`replicate` '-') widths
   in "|-" <> intercalate "-+-" pieces <> "-|"

pad :: String -> Int -> String
pad s len = s <> replicate (len - length s) ' '

renderRow :: [Int] -> [String] -> String
renderRow widths row =
  let padded = zipWith pad row widths
   in "| " <> intercalate " | " padded <> " |"

renderTable :: [String] -> [[String]] -> String
renderTable header rows =
  let widths = maxWidths header rows
   in intercalate
        "\n"
        ( [renderSeparator widths, renderRow widths header, renderSeparator widths]
            <> map (renderRow widths) rows
            <> [renderSeparator widths]
        )

main :: IO ()
main =
  putStrLn $
    renderTable
      ["Elev", "Karakter"]
      [["Per", "A"], ["Edvard", "F-"], ["Asbjørn", "B+"]]
