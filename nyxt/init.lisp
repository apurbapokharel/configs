; ------------------ key bindings start ---------------------;
(define-configuration buffer
  ((override-map (let ((map (make-keymap "override-map")))
                   (define-key map
                     "C-x" 'describe-command
										;buffer navigation
										 "M-x" 'delete-current-buffer
                     "C-space" 'switch-buffer
                    )))))

(define-configuration nyxt/vi-mode:vi-normal-mode
  ((keymap-scheme
    (let ((scheme %slot-default%))
      (define-key (gethash scheme:vi-normal scheme)
      ;query in search engine
        "M-s" 'query-selection-in-search-engine
      ;history
        "h t" 'nyxt/web-mode:history-tree
      ;boookmarks
        "b c" 'bookmark-current-url
        "b b" 'bookmark-buffer-url
        "b u" 'bookmark-url
        "b o" 'set-url-from-bookmark
        "b d" 'delete-bookmark
        "b l" 'list-bookmarks)
      scheme))))

(define-configuration web-buffer
    ((default-modes (append '(nyxt/vi-mode:vi-normal-mode) %slot-default%))))

(define-configuration (prompt-buffer)
  ((default-modes (append
                   '(vi-insert-mode)
                   %slot-default%))))

; ------------------ key bindings end ---------------------;

; ------------------ search engine start---------------------;
(defvar *my-search-engines*
  (list
   '("google" "https://www.google.com/search?q=~a" "https://www.google.com/")))

(define-configuration buffer
  ((search-engines (append %slot-default% (mapcar (lambda (engine) (apply 'make-search-engine engine))
                                                  *my-search-engines*)))))

; ------------------ search engine end ---------------------;

; ------------------ style start ---------------------;
; Window

(define-configuration prompt-buffer
  ((style (str:concat
           %slot-default%
           (cl-css:css
            '((body
               :background-color "#2E3440"
               :color "white")
              ("#prompt-area"
               :background-color "#2E3440")
              ("#input"
               :background-color "white")
              (".source-name"
               :color "white"
               :background-color "#5E81AC")
              (".source-content"
               :background-color "#2E3440")
              (".source-content th"
               :border "1px solid #5E81AC"
               :background-color "#2E3440")
              ("#selection"
               :background-color "#A3BE8C"
               :color "black")
              (.marked :background-color "#BF616A"
                       :font-weight "bold"
                       :color "white")
              (.selected :background-color "#2E3440"
                         :color "white")))))))
; Internal buffer
(define-configuration internal-buffer
  ((style
    (str:concat
     %slot-default%
     (cl-css:css
      '((title
         :color "#CD5C5C")
        (body
         :background-color "#3B4252"
         :color "lightgray")
        (hr
         :color "darkgray")
        (a
         :color "lightgray")
        (.button
         :color "lightgray"
        :background-color "#434C5E")))))))

; History tree page
(define-configuration nyxt/history-tree-mode:history-tree-mode
  ((nyxt/history-tree-mode::style
    (str:concat
     %slot-default%
     (cl-css:css
      '((body
         :background-color "black"
         :color "lightgray")
        (hr
         :color "darkgray")
        (a
         :color "#A3BE8C")
        ("ul li::before"
         :background-color "white")
        ("ul li::after"
         :background-color "white")
        ("ul li:only-child::before"
         :background-color "white")))))))

(define-configuration nyxt/web-mode:web-mode
  ((nyxt/web-mode:highlighted-box-style
    (cl-css:css
     '((".nyxt-hint.nyxt-highlight-hint"
        :background "#CD5C5C")))
    :documentation "The style of highlighted boxes, e.g. link hints.")))

; Bottom status bar
(define-configuration status-buffer
  ((height 32)))

(define-configuration window
  ((message-buffer-height 20)
   (message-buffer-style
    (str:concat
     %slot-default%
     (cl-css:css
      '((body
         :background-color "#2E3440"
         :color "#EBCB8B")))))))

(define-configuration status-buffer
  ((style (str:concat
           %slot-default%
           (cl-css:css
            '((body
               :font-size "14px"
               :background "#2E3440"
               :padding-bottom "2px"
               :line-height "24px"
               )
              (
               "#controls"
               :background-color "#5E81AC")
              ("#url"
               :background-color "#434C5E"
               :color "white")
              ("#modes"
               :background-color "#434C5E")
              ("#tabs"
               :background-color "#4C566A"
               :color "black")))))))

; (define-configuration window
;   ((message-buffer-height 20)))
; ------------------ style end ---------------------;

