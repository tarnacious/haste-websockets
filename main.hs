{-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import Haste

newtype Worker = Worker JSAny

foreign import ccall make_worker :: JSString -> IO Worker
foreign import ccall on_message :: Worker -> JSFun (JSString -> IO ()) -> IO ()
foreign import ccall send_message :: Worker -> JSString -> IO ()
foreign import ccall log_message :: JSString -> IO ()

message :: Worker -> (JSString -> IO ()) -> IO ()
message worker f = on_message worker $ mkCallback f

send :: Worker -> JSString -> IO ()
send worker message = send_message worker message

append_message :: Elem -> String -> IO ()
append_message el s = do
    c <- getProp el "innerHTML"
    setProp el "innerHTML" $ c ++ "<br>" ++ s

handle_message :: Elem -> JSString -> IO ()
handle_message el s = append_message el s'
    where Just s' = fromJSString s

main = do
    Just el <- elemById "output"
    worker <- make_worker (toJSString "worker.js")
    message worker (\s -> handle_message el s) 
    send worker $ toJSString "Hello worker!"
    

