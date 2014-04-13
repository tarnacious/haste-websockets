{-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import Haste
import Chess
import Board
import Minimax
import Moves
import Game

foreign import ccall on_message :: JSFun (JSString -> IO ()) -> IO ()
foreign import ccall send_message :: JSString -> IO ()

message :: (JSString -> IO ()) -> IO ()
message f = on_message $ mkCallback f

send :: JSString -> IO ()
send message = send_message message

game :: State -> IO ()
game s = do
    send $ (toJSString . prettyBoard . snd) s
    game $ doMove s

main = do
    game (White, initialBoard)
