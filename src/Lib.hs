{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Lib ( demo ) where

import qualified Language.C.Inline            as C
import qualified Data.Vector.Storable         as V
import qualified Data.Vector.Storable.Mutable as VM
import           Data.Monoid ((<>))
import           Foreign.C.Types

-- To use the vector anti-quoters, we need 'C.vecCtx' along with 'C.baseCtx'.
C.context (C.baseCtx <> C.vecCtx)

sumVec :: VM.IOVector CDouble -> IO CDouble
sumVec vec = [C.block| double {
    double sum = 0;
    int i;
    for (i = 0; i < $vec-len:vec; i++) {
      sum += $vec-ptr:(double *vec)[i];
    }
    return sum;
  } |]

demo :: IO ()
demo = do
  x <- sumVec =<< V.thaw (V.fromList [1,2,3])
  print x
