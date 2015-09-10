{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
-- | This module is intended to be imported @qualified@, for example:
--
-- > import qualified Test.SmallCheck.Lens.Traversal as Traversal
--
module Test.SmallCheck.Lens.Traversal where

import Prelude hiding (pure)
import qualified Prelude (pure)
import Data.Proxy
#if !MIN_VERSION_base(4,8,0)
import Control.Applicative (Applicative, pure)
#endif
import Control.Lens
import Data.Functor.Compose (Compose(..), getCompose)
import Test.SmallCheck (Property)
import qualified Test.SmallCheck as SC (over)
import Test.SmallCheck.Series (Serial, Series)
import Test.SmallCheck.Series.Utils (zipLogic3)

pure
  :: forall m f s a. (Monad m, Show s, Applicative f, Eq (f s))
  => Proxy f -> Traversal' s a -> Series m s -> Property m
pure _ l ss = SC.over ss $ \s -> l Prelude.pure s == (Prelude.pure s :: f s)

composition
  :: ( Monad m, Show s, Show a, Show (f a), Show (g a)
     , Applicative f, Applicative g, Eq (g (f s)), Serial Identity a
     )
  => Traversal' s a
  -> Series m s
  -> Series m (a -> f a)
  -> Series m (a -> g a)
  -> Property m
composition t ss fs gs =
    SC.over ss $ \s ->
        SC.over fs $ \f ->
            SC.over gs $ \g ->
    (fmap (t f) . t g) s == (getCompose . t (Compose . fmap f . g)) s

compositionSum
  :: ( Monad m, Show s, Show a, Show (f a), Show (g a)
     , Applicative f, Applicative g, Eq (g (f s)), Serial Identity a
     )
  => Traversal' s a
  -> Series m s
  -> Series m (a -> f a)
  -> Series m (a -> g a)
  -> Property m
compositionSum t ss fs gs = SC.over (zipLogic3 ss fs gs) $ \(s,f,g) ->
    (fmap (t f) . t g) s == (getCompose . t (Compose . fmap f . g)) s
