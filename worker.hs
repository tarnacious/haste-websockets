{-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import Haste
import Control.Monad (when)

foreign import ccall on_message :: JSFun (String -> IO ()) -> IO ()
foreign import ccall send_message :: JSString -> IO ()

message :: (String -> IO ()) -> IO ()
message f = on_message $ mkCallback f

send :: String -> IO ()
send message = send_message (toJSString message)

main = do
    send "Hello von Web Worker"
    message (\x -> send x)

