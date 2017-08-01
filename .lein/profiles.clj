{:user {:plugins [[cider/cider-nrepl "0.15.0"]
                  [lein-cljfmt "0.5.6"]
                  [jonase/eastwood "0.2.1"]]
        :dependencies [[jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]
                       [cljfmt "0.5.6"]]
        :repl-options {:init (require 'cljfmt.core)}}}
