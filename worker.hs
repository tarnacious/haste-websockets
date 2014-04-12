{-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import Haste

foreign import ccall on_message :: JSFun (JSString -> IO ()) -> IO ()
foreign import ccall send_message :: JSString -> IO ()

message :: (JSString -> IO ()) -> IO ()
message f = on_message $ mkCallback f

send :: JSString -> IO ()
send message = send_message message

response :: JSString ->  JSString 
response s = toJSString $ "Worker: Recieved, " ++ s'
    where Just s' = fromJSString s

main = do
    send $ toJSString "Worker: Hello"
    message (\x -> send (response x))
