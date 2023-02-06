; A Note on anonymous nodes (represented in a query file as strings). As of
; right now, anonymous nodes can not be anchored.
; See https://github.com/tree-sitter/tree-sitter/issues/1461

; Example highlighting for headlines. The headlines here will be matched
; cyclically, easily extended to match however your heart desires.
(headline (stars) @OrgTSStars1 (#match? @OrgTSStars1 "^(\\*{3})*\\*$") (item) @OrgHeadlineLevel1)
(headline (stars) @OrgTSStars2 (#match? @OrgTSStars2 "^(\\*{3})*\\*\\*$") (item) @OrgHeadlineLevel2)
(headline (stars) @OrgTSStars3 (#match? @OrgTSStars3 "^(\\*{3})*\\*\\*\\*$") (item) @OrgHeadlineLevel3)

; This one should be generated after scanning for configuration, using 
; something like #any-of? for keywords, but could use a match if allowing
; markup on todo keywords is desirable.
(item . (expr) @OrgTSKeywordTodo (#eq? @OrgTSKeywordTodo "TODO"))
(item . (expr) @OrgTSKeywordDone (#eq? @OrgTSKeywordDone "DONE"))

(headline . (headline))
; (item (expr) @OrgTSStars1 (#lua_match? "TODO" @OrgTSKeywordTodo))
; (headline (stars) @OrgTSKeywordDone (#eq? ))
; (item . (expr) @OrgTSKeywordDone (#eq? @OrgTSKeywordDone "DONE"))

; Not sure about this one with the anchors.
(item . (expr)? . (expr "[" "#" @OrgTSPriority [ "num" "str" ] @OrgTSPriority "]") @OrgPriorityCookie (#match? @OrgPriorityCookie "\[#.\]"))

; Match cookies in a headline or listitem. If you want the numbers
; differently highlighted from the borders, add a capture name to "num".
; ([ (item) (itemtext) ] (expr "[" "num"? @OrgCookieNum "/" "num"? @OrgCookieNum "]" ) @OrgProgressCookie (#match? @OrgProgressCookie "^\[\d*/\d*\]$"))
; ([ (item) (itemtext) ] (expr "[" "num"? @OrgCookieNum "%" "]" ) @OrgPercentCookie (#match? @OrgPercentCookie "^\[\d*%\]$"))

(tag_list (tag) @OrgTSTag) @OrgTSTagList

(property_drawer) @OrgTSPropertyDrawer

; Properties are :name: vale, so to color the ':' we can either add them
; directly, or highlight the property separately from the name and value. If
; priorities are set properly, it should be simple to achieve.
(property name: (expr) @OrgTSPropertyName (value)? @OrgTSPropertyValue) @OrgTSProperty

; Simple examples, but can also match (day), (date), (time), etc.
(timestamp "[") @OrgTSTimestampInactive
(timestamp "<"
 (day)? @OrgTSTimestampDay
 (date)? @OrgTSTimestampDate
 (time)? @OrgTSTimestampTime
 (repeat)? @OrgTSTimestampRepeat
 (delay)? @OrgTSTimestampDelay
 ) @OrgTSTimestampActive

; Like OrgProperty, easy to choose how the '[fn:LABEL] DESCRIPTION' are highlighted
(fndef label: (expr) @OrgTSFootnoteLabel (description) @OrgTSFootnoteDescription) @OrgTSFootnoteDefinition

; Again like OrgProperty to change the styling of '#+' and ':'. Note that they
; can also be added in the query directly as anonymous nodes to style differently.
(directive name: (expr) @OrgTSDirectiveName (value)? @OrgTSDirectiveValue) @OrgTSDirective

(comment) @OrgTSComment

; At the moment, these three elements use one regex for the whole name.
; So (name) -> :name:, ideally this will not be the case, so it follows the
; patterns listed above, but that's the current status. Conflict issues.
(drawer name: (expr) @OrgTSDrawerName (contents)? @OrgTSDrawerContents) @OrgTSDrawer
(block name: (expr) @OrgTSBlockName (contents)? @OrgTSBlockContents) @OrgTSBlock
(dynamic_block name: (expr) @OrgTSDynamicBlockName (contents)? @OrgTSDynamicBlockContents) @OrgTSDynamicBlock

; Can match different styles with a (#match?) or (#eq?) predicate if desired
(bullet) @OrgTSListBullet

; Get different colors for different statuses as follows
(checkbox) @OrgTSCheckbox
(checkbox status: (expr "-") @OrgTSCheckInProgress)
(checkbox status: (expr "str") @OrgTSCheckDone (#any-of? @OrgTSCheckDone "x" "X"))
(checkbox status: (expr) @Error (#not-any-of? @Error "x" "X" "-"))

; If you want the ruler one color and the separators a different color,
; something like this would do it:
; (hr "|" @OrgTableHRBar) @OrgTableHorizontalRuler
(hr) @OrgTSTableHorizontalRuler

; Can do all sorts of fun highlighting here..
(cell (contents . (expr "=")) @OrgTSCellFormula (#match? @OrgTSCellFormula "^\d+([.,]\d+)*$"))

; Dollars, floats, etc. Strings.. all options to play with
(cell (contents . (expr "num") @OrgTSCellNumber (#match? @OrgTSCellNumber "^\d+([.,]\d+)*$") .))
