{-# LANGUAGE RankNTypes #-}
module Control.Lens.Iso.Laws where

import Control.Lens

hither :: Eq s => Iso' s a -> s -> Bool
hither l s = s ^. l . from l == s

yon :: Eq a => Iso' s a -> a -> Bool
yon l a = a ^. from l . l == a
