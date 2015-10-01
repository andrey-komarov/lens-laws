{-# LANGUAGE CPP #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Control.Lens.Traversal.Laws where

#if MIN_VERSION_base(4,8,0)
import Prelude hiding (pure)
import qualified Prelude (pure)
#else
import Control.Applicative (Applicative)
import qualified Control.Applicative as Prelude (pure)
#endif
import Data.Proxy (Proxy)
import Data.Functor.Compose (Compose(..), getCompose)
import Control.Lens

pure
  :: forall f s a. (Applicative f, Eq (f s))
  => Proxy f -> Traversal' s a -> s -> Bool
pure _ l s = l Prelude.pure s == (Prelude.pure s :: f s)

composition
  :: (Applicative f, Applicative g, Eq (g (f s)))
  => Traversal' s a -> s -> (a -> f a) -> (a -> g a) -> Bool
composition t s f g = (fmap (t f) . t g) s == (getCompose . t (Compose . fmap f . g)) s
