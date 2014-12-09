#lang racket/gui
(require xml)

(define frame
  (new frame%
       [label "RSS Reader"]
       [min-width 400]
       [min-height 640]))

(define menu-bar
  (new menu-bar%
       [parent frame]))

(define rss-menu
  (new menu%
       [label "&RSS"]
       [parent menu-bar]))

(define add-rss-feed
  (new menu-item%
       [label "&Add"]
       [parent rss-menu]
       (callback (lambda (menu event)
                   (define add-rss
                     (new dialog%
                          [label "Add new RSS feed"]
                          [min-width 400]
                          [stretchable-height #f]))
                   
                   (define horizontal-panel
                     (new horizontal-panel%
                          [parent add-rss]))
                   
                   (define feed-url
                     (new text-field%
                          [label #f]
                          [parent horizontal-panel]
                          [style '(single)]))
                   
                   (define add
                     (new button%
                          [parent horizontal-panel]
                          [label "Add"]
                          [style '(border)]))
                   
                   (send add-rss show #t)))))
(define delete
  (new menu-item%
       [label "&Delete"]
       [parent rss-menu]
       (callback (lambda (menu event)
                   (define delete-rss
                     (new dialog%
                          [label "Delete one or more RSS feeds"]
                          [min-width 400]
                          [stretchable-height #f]))
                   
                   (define vertical-panel
                     (new vertical-panel%
                          [parent delete-rss]
                          [alignment '(left center)]))
                   
                   (define delete
                     (new button%
                          [parent vertical-panel]
                          [label "Delete"]))
                   
                   (send delete-rss show #t)))))
(define update
  (new menu-item%
       [label "&Update"]
       [parent rss-menu]
       (callback (lambda (menu event)
                   (+ 1 1)))))

(define feeds
  (new vertical-panel%
       [parent frame]
       [style '(vscroll)]
       [alignment '(left center)]))

(define default-feeds-xml
  '(feeds (url "google.com") (url)))

;(display-xml/content
; (xexpr->xml default-feeds-xml))

(define output
  (open-output-file"output.xml"
                         #:exists 'truncate/replace)) 

(write-xml/content
 (xexpr->xml
  (xml->xexpr (document-element
             (read-xml/document (open-input-file "feeds.xml")))))
 output)

;(send frame show #t)