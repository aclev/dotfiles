{:user
 {:repositories [["amperity" {:url "https://s3-us-west-2.amazonaws.com/amperity-static-packages/jars/"
                              :snapshots false}]]
  :plugins [[lein-monolith "1.0.1"]
            [lein-cloverage "1.0.13"]
            [amperity/lein-cljfmt "0.7.0-SNAPSHOT"]
            [cider/cider-nrepl "0.21.1" :exclusions [org.clojure/tools.logging]]]
  :dependencies [[cider/cider-nrepl "0.21.1" :exclusions [org.clojure/tools.logging]]
                 [mvxcvi/whidbey "2.1.0"]
                 [amperity/lein-cljfmt "0.7.0-SNAPSHOT"]
                 [pjstadig/humane-test-output "0.8.3"]
                 [criterium "0.4.5"]]
  :injections [(require 'pjstadig.humane-test-output)
               (pjstadig.humane-test-output/activate!)]}}
