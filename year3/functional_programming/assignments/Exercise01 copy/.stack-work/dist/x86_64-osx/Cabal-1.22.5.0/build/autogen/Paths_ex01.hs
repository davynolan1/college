module Paths_ex01 (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/davynolan/CSU34016-1920/Exercise01/.stack-work/install/x86_64-osx/44ca9a5dda08ba0a236b9218b397b1b4ded7371218d7bfdbb75dad9e9e78a43c/7.10.3/bin"
libdir     = "/Users/davynolan/CSU34016-1920/Exercise01/.stack-work/install/x86_64-osx/44ca9a5dda08ba0a236b9218b397b1b4ded7371218d7bfdbb75dad9e9e78a43c/7.10.3/lib/x86_64-osx-ghc-7.10.3/ex01-0.1.0.0-IxeruUelu6KJbIfS7prgY8"
datadir    = "/Users/davynolan/CSU34016-1920/Exercise01/.stack-work/install/x86_64-osx/44ca9a5dda08ba0a236b9218b397b1b4ded7371218d7bfdbb75dad9e9e78a43c/7.10.3/share/x86_64-osx-ghc-7.10.3/ex01-0.1.0.0"
libexecdir = "/Users/davynolan/CSU34016-1920/Exercise01/.stack-work/install/x86_64-osx/44ca9a5dda08ba0a236b9218b397b1b4ded7371218d7bfdbb75dad9e9e78a43c/7.10.3/libexec"
sysconfdir = "/Users/davynolan/CSU34016-1920/Exercise01/.stack-work/install/x86_64-osx/44ca9a5dda08ba0a236b9218b397b1b4ded7371218d7bfdbb75dad9e9e78a43c/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ex01_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ex01_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "ex01_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ex01_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ex01_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
