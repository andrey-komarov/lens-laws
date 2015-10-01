{-# LANGUAGE RankNTypes #-}
module Control.Lens.Prism.Laws where

import Control.Lens

yin :: Eq a => Prism' s a -> a -> Bool
yin l a = preview l (review l a) == Just a

yang :: Eq s => Prism' s a -> s -> Bool
yang l s = maybe s (review l) (preview l s) == s
