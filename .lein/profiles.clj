{:user {:plugins [[cider/cider-nrepl "0.14.0" :exclusions [org.clojure/tools.nrepl]]
                  #_[lein-cljfmt "0.5.7" :exclusions [org.clojure/clojure]]
                  #_[jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]
                  [lein-monolith "1.0.1"]]
        :dependencies [ [cljfmt "0.5.1" :exclusions [org.clojure/clojurescript org.clojure/clojure]] [jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]]
        :repl-options { #_#_:init (require `cljfmt) :timeout 1200000}}}
