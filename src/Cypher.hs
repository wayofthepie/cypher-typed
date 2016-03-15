module Cypher where

import Control.Monad
import Control.Monad.State.Strict
import qualified Data.Text as T
import Data.HashMap.Strict as M



data CypherQuery  = CypherQuery { query :: T.Text }
data CypherItem =
    Neo4jNode { nprops :: [(T.Text,T.Text)], nlabels :: [T.Text] }
    | Neo4jRelation { rprops :: [(T.Text,T.Text)], rlabels :: [T.Text] }

newtype Cypher a = Cypher (State (M.HashMap T.Text CypherItem) a)


bind :: T.Text -> CypherItem -> State (M.HashMap T.Text CypherItem) ()
bind k n@(Neo4jNode _ _)     = get >>= \m -> put (M.insert k n m)
bind k r@(Neo4jRelation _ _) = get >>= \m -> put (M.insert k r m)



match ("a" |: (Node props labels), "b" |: (Node props labels))
    merge (Node props labels) >>=


