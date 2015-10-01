{-# LANGUAGE RankNTypes #-}
module Control.Lens.Setter.Laws where

import Control.Lens

identity :: Eq s => Setter' s a -> s -> Bool
identity l s = over l id s == s

setSet :: Eq s => Setter' s a -> s -> a -> a -> Bool
setSet l s a b = set l b (set l a s) == set l b s

composition
  :: Eq s => Setter' s a -> s -> (a -> a) -> (a -> a) -> Bool
composition l s f g = over l f (over l g s) == over l (f . g) s
