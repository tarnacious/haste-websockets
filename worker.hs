{-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import Haste
import Chess
import Board
import Minimax
import Moves
import Game

foreign import ccall on_message :: JSFun (JSString -> IO ()) -> IO ()
foreign import ccall post_message :: JSString -> IO ()

message :: (JSString -> IO ()) -> IO ()
message f = on_message $ mkCallback f

game :: State -> IO ()
game s = do
    post_message $ (toJSString . prettyBoard . snd) s
    game $ doMove s

main = do
    game (White, initialBoard)
