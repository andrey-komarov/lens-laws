{-# LANGUAGE RankNTypes #-}
module Control.Lens.Lens.Laws where

import Control.Lens

setView :: Eq s => Lens' s a -> s -> Bool
setView l s = set l (view l s) s == s

viewSet :: Eq a => Lens' s a -> s -> a -> Bool
viewSet l s a = view l (set l a s) == a
