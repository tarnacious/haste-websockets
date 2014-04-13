{-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import Haste

newtype Worker = Worker JSAny

foreign import ccall make_worker :: JSString -> IO Worker
foreign import ccall on_message :: Worker -> JSFun (JSString -> IO ()) -> IO ()

message :: Worker -> (JSString -> IO ()) -> IO ()
message worker f = on_message worker $ mkCallback f

handle_message :: Elem -> JSString -> IO ()
handle_message el s = setProp el "innerHTML" s'
    where Just s' = fromJSString s

main = do
    Just el <- elemById "output"
    worker <- make_worker (toJSString "worker.js")
    message worker (\s -> handle_message el s) 
    

