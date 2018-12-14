;; This software is Copyright (c) 2003-2010  Peter Herth <herth@peter-herth.de>
;; Portions Copyright (c) 2005-2010 Thomas F. Burdick
;; Portions Copyright (c) 2006-2010 Cadence Design Systems
;; Portions Copyright (c) 2010 Daniel Herring
;; Portions Copyright (c) 2018 cage

;; The  authors  grant you  the  rights  to  distribute and  use  this
;; software as  governed by the  terms of  the Lisp Lesser  GNU Public
;; License  (http://opensource.franz.com/preamble.html), known  as the
;; LLGPL.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT  ANY  WARRANTY;  without   even  the  implied  warranty  of
;; MERCHANTABILITY or FITNESS  FOR A PARTICULAR PURPOSE.   See the GNU
;; General Public License for more details.

(defpackage :nodgui.config
  (:use :cl
        :alexandria)
  (:export :+nodgui-version+))

(defpackage :nodgui.constants
  (:use :cl
        :alexandria)
  (:export :+wish-to-lisp-data-reply+
           :+wish-to-lisp-error-reply+
           :+wish-to-lisp-callback-reply+
           :+wish-to-lisp-keepalive-reply+
           :+wish-to-lisp-event-reply+))

(defpackage :nodgui.utils
  (:use :cl
        :alexandria
        :cl-ppcre)
  (:export :format-fn-symbol
           :format-keyword
           :to-s
           :strcat
           :strcat*
           :strip-prefix
           :strip-withespaces
           :join-with-strings
           :join-with-strings*
           :trim
           :make-adjustable-string
           :encode-base-52
           :split-sequence
           :make-fresh-list
           :delete@
           :safe-delete@
           :make-array-frame
           :make-fresh-array
           :read-into-array
           :pngp
           :gifp
           :jpgp
           :rgb->tk
           :*default-epsilon*
           :with-epsilon
           :add-epsilon-rel
           :epsilon<=
           :epsilon>=
           :epsilon=
           :define-parse-header-chunk
           :define-offset-size
           :byte->int
           :int16->bytes
           :round-all
           :->f
           :rad->deg
           :deg->rad
           :nodgui-color-syntax))

(defpackage :nodgui.base64
  (:use :cl
        :alexandria
        :cl-ppcre
        :nodgui.utils)
  (:export :encode
           :decode))

(defpackage :nodgui.ubvec4
  (:use :cl
        :nodgui.constants
        :nodgui.utils)
  (:export
   :ubvec4-type
   :ubvec4
   :ubvec4p
   :copy-ubvec4
   :make-fresh-ubvec4
   :ubvec4=
   :+ubvec4-zero+
   :ubvec4*
   :ubvec4/
   :ubvec4=
   :ubvec4~
   :ubvec4+
   :ubvec4-
   :ubvec4-length
   :ubvec4-normalize
   :ubvec4-dot-product))

(defpackage :nodgui.vec2
  (:use :cl
        :nodgui.constants
        :nodgui.utils)
  (:export
      :vec2-type
   :vec2
   :+vec2-zero+
   :sequence->vec2
   :make-fresh-vec2
   :copy-vec2
   :vec2-x
   :vec2-y
   :vec2p
   :vec2*
   :vec2/
   :vec2~
   :vec2=
   :vec2+
   :vec2-
   :vec2-negate
   :vec2-length
   :vec2-normalize
   :vec2-dot-product
   :vec2-perpendicular
   :vec2-perp-dot-product
   :vec2-rotate))

(defpackage :nodgui.pixmap
  (:use :cl
        :alexandria
        :nodgui.constants
        :nodgui.utils
        :nodgui.ubvec4
        :nodgui.vec2)
  (:export
   :pixmap
   :width
   :height
   :data
   :bits
   :sync-bits-to-data
   :sync-data-to-bits
   :tga
   :jpeg
   :slurp-pixmap
   :load-from-stream
   :h-mirror
   :v-mirror
   :scale-nearest
   :scale-bilinear
   :rotate-pixmap))

(defpackage :nodgui.event-symbols
  (:use :cl
        :alexandria
        :cl-ppcre
        :nodgui.utils)
  (:export
   :*all-event-details*
   :*all-event-modifier*
   :*all-event-type*
   ;; details
   :+space+
   :+exclam+
   :+quotedbl+
   :+numbersign+
   :+dollar+
   :+percent+
   :+ampersand+
   :+quoteright+
   :+parenleft+
   :+parenright+
   :+asterisk+
   :+plus+
   :+comma+
   :+minus+
   :+period+
   :+slash+
   :+colon+
   :+semicolon+
   :+less+
   :+equal+
   :+greater+
   :+question+
   :+at+
   :+bracketleft+
   :+backslash+
   :+bracketright+
   :+asciicircum+
   :+underscore+
   :+quoteleft+
   :+braceleft+
   :+bar+
   :+braceright+
   :+asciitilde+
   :+nobreakspace+
   :+exclamdown+
   :+cent+
   :+sterling+
   :+currency+
   :+yen+
   :+brokenbar+
   :+section+
   :+diaeresis+
   :+copyright+
   :+ordfeminine+
   :+guillemotleft+
   :+notsign+
   :+hyphen+
   :+registered+
   :+macron+
   :+degree+
   :+plusminus+
   :+twosuperior+
   :+threesuperior+
   :+acute+
   :+mu+
   :+paragraph+
   :+periodcentered+
   :+cedilla+
   :+onesuperior+
   :+masculine+
   :+guillemotright+
   :+onequarter+
   :+onehalf+
   :+threequarters+
   :+questiondown+
   :+acircumflex+
   :+atilde+
   :+adiaeresis+
   :+aring+
   :+ccedilla+
   :+eth+
   :+multiply+
   :+ooblique+
   :+ssharp+
   :+agrave+
   :+aacute+
   :+acircumflex+
   :+ae+
   :+egrave+
   :+eacute+
   :+ecircumflex+
   :+ediaeresis+
   :+igrave+
   :+iacute+
   :+icircumflex+
   :+idiaeresis+
   :+ntilde+
   :+ograve+
   :+oacute+
   :+ocircumflex+
   :+otilde+
   :+odiaeresis+
   :+division+
   :+oslash+
   :+ugrave+
   :+uacute+
   :+ucircumflex+
   :+udiaeresis+
   :+yacute+
   :+thorn+
   :+ydiaeresis+
   :+breve+
   :+aogonek+
   :+ogonek+
   :+lstroke+
   :+lcaron+
   :+sacute+
   :+caron+
   :+scaron+
   :+scedilla+
   :+tcaron+
   :+zacute+
   :+doubleacute+
   :+zcaron+
   :+zabovedot+
   :+abreve+
   :+cacute+
   :+ccaron+
   :+eogonek+
   :+ecaron+
   :+dcaron+
   :+nacute+
   :+ncaron+
   :+odoubleacute+
   :+rcaron+
   :+uring+
   :+udoubleacute+
   :+tcedilla+
   :+abovedot+
   :+hstroke+
   :+hcircumflex+
   :+idotless+
   :+gbreve+
   :+jcircumflex+
   :+cabovedot+
   :+ccircumflex+
   :+gabovedot+
   :+gcircumflex+
   :+ubreve+
   :+scircumflex+
   :+kappa+
   :+rcedilla+
   :+itilde+
   :+lcedilla+
   :+emacron+
   :+gacute+
   :+tslash+
   :+eng+
   :+amacron+
   :+iogonek+
   :+eabovedot+
   :+imacron+
   :+ncedilla+
   :+omacron+
   :+kcedilla+
   :+uogonek+
   :+utilde+
   :+umacron+
   :+overline+
   :+kana-fullstop+
   :+kana-openingbracket+
   :+kana-closingbracket+
   :+kana-comma+
   :+kana-middledot+
   :+kana-wo+
   :+kana-a+
   :+kana-i+
   :+kana-u+
   :+kana-e+
   :+kana-o+
   :+kana-ya+
   :+kana-yu+
   :+kana-yo+
   :+kana-tu+
   :+prolongedsound+
   :+voicedsound+
   :+semivoicedsound+
   :+arabic-comma+
   :+arabic-semicolon+
   :+arabic-question-mark+
   :+arabic-hamza+
   :+arabic-maddaonalef+
   :+arabic-hamzaonalef+
   :+arabic-hamzaonwaw+
   :+arabic-hamzaunderalef+
   :+arabic-hamzaonyeh+
   :+arabic-alef+
   :+arabic-beh+
   :+arabic-tehmarbuta+
   :+arabic-teh+
   :+arabic-theh+
   :+arabic-jeem+
   :+arabic-hah+
   :+arabic-khah+
   :+arabic-dal+
   :+arabic-thal+
   :+arabic-ra+
   :+arabic-zain+
   :+arabic-seen+
   :+arabic-sheen+
   :+arabic-sad+
   :+arabic-dad+
   :+arabic-tah+
   :+arabic-zah+
   :+arabic-ain+
   :+arabic-ghain+
   :+arabic-tatweel+
   :+arabic-feh+
   :+arabic-qaf+
   :+arabic-kaf+
   :+arabic-lam+
   :+arabic-meem+
   :+arabic-noon+
   :+arabic-heh+
   :+arabic-waw+
   :+arabic-alefmaksura+
   :+arabic-yeh+
   :+arabic-fathatan+
   :+arabic-dammatan+
   :+arabic-kasratan+
   :+arabic-fatha+
   :+arabic-damma+
   :+arabic-kasra+
   :+arabic-shadda+
   :+arabic-sukun+
   :+serbian-dje+
   :+macedonia-gje+
   :+cyrillic-io+
   :+ukranian-je+
   :+macedonia-dse+
   :+ukranian-i+
   :+ukranian-yi+
   :+serbian-je+
   :+serbian-lje+
   :+serbian-nje+
   :+serbian-tshe+
   :+macedonia-kje+
   :+byelorussian-shortu+
   :+serbian-dze+
   :+numerosign+
   :+macedonia-kje+
   :+byelorussian-shortu+
   :+serbian-dze+
   :+cyrillic-yu+
   :+cyrillic-a+
   :+cyrillic-be+
   :+cyrillic-tse+
   :+cyrillic-de+
   :+cyrillic-ie+
   :+cyrillic-ef+
   :+cyrillic-ghe+
   :+cyrillic-ha+
   :+cyrillic-i+
   :+cyrillic-shorti+
   :+cyrillic-ka+
   :+cyrillic-el+
   :+cyrillic-em+
   :+cyrillic-en+
   :+cyrillic-o+
   :+cyrillic-pe+
   :+cyrillic-ya+
   :+cyrillic-er+
   :+cyrillic-es+
   :+cyrillic-te+
   :+cyrillic-u+
   :+cyrillic-zhe+
   :+cyrillic-ve+
   :+cyrillic-softsign+
   :+cyrillic-yeru+
   :+cyrillic-ze+
   :+cyrillic-sha+
   :+cyrillic-e+
   :+cyrillic-shcha+
   :+cyrillic-che+
   :+cyrillic-hardsign+
   :+greek-alphaaccent+
   :+greek-epsilonaccent+
   :+greek-etaaccent+
   :+greek-iotaaccent+
   :+greek-iotadieresis+
   :+greek-iotaaccentdieresis+
   :+greek-omicronaccent+
   :+greek-upsilonaccent+
   :+greek-upsilondieresis+
   :+greek-upsilonaccentdieresis+
   :+greek-omegaaccent+
   :+greek-alpha+
   :+greek-beta+
   :+greek-gamma+
   :+greek-delta+
   :+greek-epsilon+
   :+greek-zeta+
   :+greek-eta+
   :+greek-theta+
   :+greek-iota+
   :+greek-kappa+
   :+greek-lambda+
   :+greek-mu+
   :+greek-nu+
   :+greek-xi+
   :+greek-omicron+
   :+greek-pi+
   :+greek-rho+
   :+greek-sigma+
   :+greek-finalsmallsigma+
   :+greek-tau+
   :+greek-upsilon+
   :+greek-phi+
   :+greek-chi+
   :+greek-psi+
   :+greek-omega+
   :+leftradical+
   :+topleftradical+
   :+horizconnector+
   :+topintegral+
   :+botintegral+
   :+vertconnector+
   :+topleftsqbracket+
   :+botleftsqbracket+
   :+toprightsqbracket+
   :+botrightsqbracket+
   :+topleftparens+
   :+botleftparens+
   :+toprightparens+
   :+botrightparens+
   :+leftmiddlecurlybrace+
   :+rightmiddlecurlybrace+
   :+topleftsummation+
   :+botleftsummation+
   :+topvertsummationconnector+
   :+botvertsummationconnector+
   :+toprightsummation+
   :+botrightsummation+
   :+rightmiddlesummation+
   :+lessthanequal+
   :+notequal+
   :+greaterthanequal+
   :+integral+
   :+therefore+
   :+variation+
   :+infinity+
   :+nabla+
   :+approximate+
   :+similarequal+
   :+ifonlyif+
   :+implies+
   :+identical+
   :+radical+
   :+includedin+
   :+includes+
   :+intersection+
   :+union+
   :+logicaland+
   :+logicalor+
   :+partialderivative+
   :+function+
   :+leftarrow+
   :+uparrow+
   :+rightarrow+
   :+downarrow+
   :+blank+
   :+soliddiamond+
   :+checkerboard+
   :+ht+
   :+ff+
   :+cr+
   :+lf+
   :+nl+
   :+vt+
   :+lowrightcorner+
   :+uprightcorner+
   :+upleftcorner+
   :+lowleftcorner+
   :+crossinglines+
   :+horizlinescan1+
   :+horizlinescan3+
   :+horizlinescan5+
   :+horizlinescan7+
   :+horizlinescan9+
   :+leftt+
   :+rightt+
   :+bott+
   :+topt+
   :+vertbar+
   :+emspace+
   :+enspace+
   :+em3space+
   :+em4space+
   :+digitspace+
   :+punctspace+
   :+thinspace+
   :+hairspace+
   :+emdash+
   :+endash+
   :+signifblank+
   :+ellipsis+
   :+doubbaselinedot+
   :+onethird+
   :+twothirds+
   :+onefifth+
   :+twofifths+
   :+threefifths+
   :+fourfifths+
   :+onesixth+
   :+fivesixths+
   :+careof+
   :+figdash+
   :+leftanglebracket+
   :+decimalpoint+
   :+rightanglebracket+
   :+marker+
   :+oneeighth+
   :+threeeighths+
   :+fiveeighths+
   :+seveneighths+
   :+trademark+
   :+signaturemark+
   :+trademarkincircle+
   :+leftopentriangle+
   :+rightopentriangle+
   :+emopencircle+
   :+emopenrectangle+
   :+leftsinglequotemark+
   :+rightsinglequotemark+
   :+leftdoublequotemark+
   :+rightdoublequotemark+
   :+prescription+
   :+minutes+
   :+seconds+
   :+latincross+
   :+hexagram+
   :+filledrectbullet+
   :+filledlefttribullet+
   :+filledrighttribullet+
   :+emfilledcircle+
   :+emfilledrect+
   :+enopencircbullet+
   :+enopensquarebullet+
   :+openrectbullet+
   :+opentribulletup+
   :+opentribulletdown+
   :+openstar+
   :+enfilledcircbullet+
   :+enfilledsqbullet+
   :+filledtribulletup+
   :+filledtribulletdown+
   :+leftpointer+
   :+rightpointer+
   :+club+
   :+diamond+
   :+heart+
   :+maltesecross+
   :+dagger+
   :+doubledagger+
   :+checkmark+
   :+ballotcross+
   :+musicalsharp+
   :+musicalflat+
   :+malesymbol+
   :+femalesymbol+
   :+telephone+
   :+telephonerecorder+
   :+phonographcopyright+
   :+caret+
   :+singlelowquotemark+
   :+doublelowquotemark+
   :+cursor+
   :+leftcaret+
   :+rightcaret+
   :+downcaret+
   :+upcaret+
   :+overbar+
   :+downtack+
   :+upshoe+
   :+downstile+
   :+underbar+
   :+jot+
   :+quad+
   :+uptack+
   :+circle+
   :+upstile+
   :+downshoe+
   :+rightshoe+
   :+leftshoe+
   :+lefttack+
   :+righttack+
   :+hebrew-aleph+
   :+hebrew-beth+
   :+hebrew-gimmel+
   :+hebrew-daleth+
   :+hebrew-he+
   :+hebrew-waw+
   :+hebrew-zayin+
   :+hebrew-het+
   :+hebrew-teth+
   :+hebrew-yod+
   :+hebrew-finalkaph+
   :+hebrew-kaph+
   :+hebrew-lamed+
   :+hebrew-finalmem+
   :+hebrew-mem+
   :+hebrew-finalnun+
   :+hebrew-nun+
   :+hebrew-samekh+
   :+hebrew-ayin+
   :+hebrew-finalpe+
   :+hebrew-pe+
   :+hebrew-finalzadi+
   :+hebrew-zadi+
   :+hebrew-kuf+
   :+hebrew-resh+
   :+hebrew-shin+
   :+hebrew-taf+
   :+backspace+
   :+tab+
   :+linefeed+
   :+clear+
   :+return+
   :+pause+
   :+scroll-lock+
   :+sys-req+
   :+escape+
   :+multi-key+
   :+kanji+
   :+home+
   :+left+
   :+up+
   :+right+
   :+down+
   :+prior+
   :+next+
   :+end+
   :+begin+
   :+win-l+
   :+win-r+
   :+app+
   :+select+
   :+print+
   :+execute+
   :+insert+
   :+undo+
   :+redo+
   :+menu+
   :+find+
   :+cancel+
   :+help+
   :+break+
   :+hebrew-switch+
   :+num-lock+
   :+kp-space+
   :+kp-tab+
   :+kp-enter+
   :+kp-f1+
   :+kp-f2+
   :+kp-f3+
   :+kp-f4+
   :+kp-multiply+
   :+kp-add+
   :+kp-separator+
   :+kp-subtract+
   :+kp-decimal+
   :+kp-divide+
   :+kp-0+
   :+kp-1+
   :+kp-2+
   :+kp-3+
   :+kp-4+
   :+kp-5+
   :+kp-6+
   :+kp-7+
   :+kp-8+
   :+kp-9+
   :+kp-equal+
   :+f1+
   :+f2+
   :+f3+
   :+f4+
   :+f5+
   :+f6+
   :+f7+
   :+f8+
   :+f9+
   :+f10+
   :+l1+
   :+l2+
   :+l3+
   :+l4+
   :+l5+
   :+l6+
   :+l7+
   :+l8+
   :+l9+
   :+l10+
   :+r1+
   :+r2+
   :+r3+
   :+r4+
   :+r5+
   :+r6+
   :+r7+
   :+r8+
   :+r9+
   :+r10+
   :+r11+
   :+r12+
   :+f33+
   :+r14+
   :+r15+
   :+shift-l+
   :+shift-r+
   :+control-l+
   :+control-r+
   :+caps-lock+
   :+shift-lock+
   :+meta-l+
   :+meta-r+
   :+alt-l+
   :+alt-r+
   :+super-l+
   :+super-r+
   :+hyper-l+
   :+hyper-r+
   :+delete+
   :+xf86audiolowervolume+
   :+xf86audiomute+
   :+xf86audioraisevolume+
   :+xf86audioplay+
   :+xf86audiostop+
   :+xf86audioprev+
   :+xf86audionext+
   :+capital-agrave+
   :+capital-aacute+
   :+capital-acircumflex+
   :+capital-atilde+
   :+capital-adiaeresis+
   :+capital-aring+
   :+capital-ae+
   :+capital-ccedilla+
   :+capital-egrave+
   :+capital-eacute+
   :+capital-ecircumflex+
   :+capital-ediaeresis+
   :+capital-igrave+
   :+capital-iacute+
   :+capital-icircumflex+
   :+capital-idiaeresis+
   :+capital-eth+
   :+capital-ntilde+
   :+capital-ograve+
   :+capital-oacute+
   :+capital-ocircumflex+
   :+capital-otilde+
   :+capital-odiaeresis+
   :+capital-ugrave+
   :+capital-uacute+
   :+capital-ucircumflex+
   :+capital-udiaeresis+
   :+capital-yacute+
   :+capital-thorn+
   :+capital-aogonek+
   :+capital-lstroke+
   :+capital-lcaron+
   :+capital-sacute+
   :+capital-scaron+
   :+capital-scedilla+
   :+capital-tcaron+
   :+capital-zacute+
   :+capital-zcaron+
   :+capital-zabovedot+
   :+capital-racute+
   :+capital-abreve+
   :+capital-cacute+
   :+capital-ccaron+
   :+capital-eogonek+
   :+capital-ecaron+
   :+capital-dcaron+
   :+capital-nacute+
   :+capital-ncaron+
   :+capital-odoubleacute+
   :+capital-rcaron+
   :+capital-uring+
   :+capital-udoubleacute+
   :+capital-tcedilla+
   :+capital-hstroke+
   :+capital-hcircumflex+
   :+capital-iabovedot+
   :+capital-gbreve+
   :+capital-jcircumflex+
   :+capital-cabovedot+
   :+capital-ccircumflex+
   :+capital-gabovedot+
   :+capital-gcircumflex+
   :+capital-ubreve+
   :+capital-scircumflex+
   :+capital-rcedilla+
   :+capital-itilde+
   :+capital-lcedilla+
   :+capital-emacron+
   :+capital-gcedilla+
   :+capital-tslash+
   :+capital-eng+
   :+capital-amacron+
   :+capital-iogonek+
   :+capital-eabovedot+
   :+capital-imacron+
   :+capital-ncedilla+
   :+capital-omacron+
   :+capital-kcedilla+
   :+capital-uogonek+
   :+capital-utilde+
   :+capital-umacron+
   :+capital-kana-a+
   :+capital-kana-i+
   :+capital-kana-u+
   :+capital-kana-e+
   :+capital-kana-o+
   :+capital-kana-ka+
   :+capital-kana-ki+
   :+capital-kana-ku+
   :+capital-kana-ke+
   :+capital-kana-ko+
   :+capital-kana-sa+
   :+capital-kana-shi+
   :+capital-kana-su+
   :+capital-kana-se+
   :+capital-kana-so+
   :+capital-kana-ta+
   :+capital-kana-ti+
   :+capital-kana-tu+
   :+capital-kana-te+
   :+capital-kana-to+
   :+capital-kana-na+
   :+capital-kana-ni+
   :+capital-kana-nu+
   :+capital-kana-ne+
   :+capital-kana-no+
   :+capital-kana-ha+
   :+capital-kana-hi+
   :+capital-kana-hu+
   :+capital-kana-he+
   :+capital-kana-ho+
   :+capital-kana-ma+
   :+capital-kana-mi+
   :+capital-kana-mu+
   :+capital-kana-me+
   :+capital-kana-mo+
   :+capital-kana-ya+
   :+capital-kana-yu+
   :+capital-kana-yo+
   :+capital-kana-ra+
   :+capital-kana-ri+
   :+capital-kana-ru+
   :+capital-kana-re+
   :+capital-kana-ro+
   :+capital-kana-wa+
   :+capital-kana-n+
   :+capital-serbian-dje+
   :+capital-macedonia-gje+
   :+capital-cyrillic-io+
   :+capital-ukranian-je+
   :+capital-macedonia-dse+
   :+capital-ukranian-i+
   :+capital-ukranian-yi+
   :+capital-serbian-je+
   :+capital-serbian-lje+
   :+capital-serbian-nje+
   :+capital-serbian-tshe+
   :+capital-macedonia-kje+
   :+capital-byelorussian-shortu+
   :+capital-serbian-dze+
   :+capital-cyrillic-yu+
   :+capital-cyrillic-a+
   :+capital-cyrillic-be+
   :+capital-cyrillic-tse+
   :+capital-cyrillic-de+
   :+capital-cyrillic-ie+
   :+capital-cyrillic-ef+
   :+capital-cyrillic-ghe+
   :+capital-cyrillic-ha+
   :+capital-cyrillic-i+
   :+capital-cyrillic-shorti+
   :+capital-cyrillic-ka+
   :+capital-cyrillic-el+
   :+capital-cyrillic-em+
   :+capital-cyrillic-en+
   :+capital-cyrillic-o+
   :+capital-cyrillic-pe+
   :+capital-cyrillic-ya+
   :+capital-cyrillic-er+
   :+capital-cyrillic-es+
   :+capital-cyrillic-te+
   :+capital-cyrillic-u+
   :+capital-cyrillic-zhe+
   :+capital-cyrillic-ve+
   :+capital-cyrillic-softsign+
   :+capital-cyrillic-yeru+
   :+capital-cyrillic-ze+
   :+capital-cyrillic-sha+
   :+capital-cyrillic-e+
   :+capital-cyrillic-shcha+
   :+capital-cyrillic-che+
   :+capital-cyrillic-hardsign+
   :+capital-greek-alphaaccent+
   :+capital-greek-epsilonaccent+
   :+capital-greek-etaaccent+
   :+capital-greek-iotaaccent+
   :+capital-greek-iotadiaeresis+
   :+capital-greek-iotaaccentdiaeresis+
   :+capital-greek-omicronaccent+
   :+capital-greek-upsilonaccent+
   :+capital-greek-upsilondieresis+
   :+capital-greek-upsilonaccentdieresis+
   :+capital-greek-omegaaccent+
   :+capital-greek-alpha+
   :+capital-greek-beta+
   :+capital-greek-gamma+
   :+capital-greek-delta+
   :+capital-greek-epsilon+
   :+capital-greek-zeta+
   :+capital-greek-eta+
   :+capital-greek-theta+
   :+capital-greek-iota+
   :+capital-greek-kappa+
   :+capital-greek-lambda+
   :+capital-greek-mu+
   :+capital-greek-nu+
   :+capital-greek-xi+
   :+capital-greek-omicron+
   :+capital-greek-pi+
   :+capital-greek-rho+
   :+capital-greek-sigma+
   :+capital-greek-tau+
   :+capital-greek-upsilon+
   :+capital-greek-phi+
   :+capital-greek-chi+
   :+capital-greek-psi+
   :+capital-greek-omega+
   ;;modifier
   :+control+
   :+mod1+
   :+m1+
   :+command+
   :+alt+
   :+mod2+
   :+m2+
   :+option+
   :+shift+
   :+mod3+
   :+m3+
   :+lock+
   :+mod4+
   :+m4+
   :+extended+
   :+mod5+
   :+m5+
   :+button1+
   :+b1+
   :+meta+
   :+m+
   :+button2+
   :+b2+
   :+double+
   :+button3+
   :+b3+
   :+triple+
   :+button4+
   :+b4+
   :+quadruple+
   :+button5+
   :+b5+
   :+control+
   ;; type
   :+activate+
   :+destroy+
   :+map+
   :+buttonpress+
   :+button+
   :+enter+
   :+maprequest+
   :+buttonrelease+
   :+expose+
   :+motion+
   :+circulate+
   :+focusin+
   :+mousewheel+
   :+circulaterequest+
   :+focusout+
   :+property+
   :+colormap+
   :+gravity+
   :+reparent+
   :+configure+
   :+keypress+
   :+key+
   :+resizerequest+
   :+configurerequest+
   :+keyrelease+
   :+unmap+
   :+create+
   :+leave+
   :+visibility+
   :+deactivate+))

(defpackage :nodgui.conditions
  (:use :cl
        :alexandria
        :cl-ppcre
        :nodgui.utils)
  (:export :out-of-bounds
           :nodgui-error
           :tk-error
           :tk-communication-error
           :nodgui-event-too-many-fields
           :nodgui-event-field-has-space
           :nodgui-event-invalid-modifier
           :nodgui-event-invalid-detail
           :nodgui-event-duplicate-modifier
           :nodgui-event-incompatible-type-detail
           :nodgui-event-invalid-field
           :with-default-on-error))

(defpackage :nodgui.tcl-emitter
  (:use :cl
        :alexandria
        :cl-ppcre
        :nodgui.config
        :nodgui.constants
        :nodgui.utils)
  (:export :*suppress-newline-for-tcl-statements*
           :*add-space-after-emitted-string*
           :tcl
           :tcl-str
           :tclize
           :defproc
           :with-flush-server
           :for-list))

(defpackage :nodgui.tcl-glue-code
  (:use :cl
        :alexandria
        :nodgui.config
        :nodgui.constants
        :nodgui.utils
        :nodgui.tcl-emitter)
  (:export :wish-init-code
           :tcl-init-code
           :tcl-send-data-code))

(defpackage :nodgui.event-parser
  (:use :cl
        :alexandria
        :cl-ppcre
        :yacc
        :cl-lex
        :nodgui.utils
        :nodgui.conditions
        :nodgui.event-symbols)
  (:export
   :*check-more-parsing-errors*
   :+delim-left+
   :+delim-right+
   :+delim-field+
   :+field+
   :+filler+
   :lexer
   :parse-event
   :nodgui-event-syntax))

(defpackage :nodgui
  (:use :cl
        #+(or :cmu :scl) :ext
        :nodgui.config
        :nodgui.constants
        :nodgui.tcl-glue-code
        :nodgui.utils
        :nodgui.conditions
        :nodgui.pixmap
        :nodgui.event-parser
        :nodgui.tcl-emitter)
  (:export :syntax
           :+type-desktop+
           :+type-dock+
           :+type-toolbar+
           :+type-menu+
           :+type-utility+
           :+type-splash+
           :+type-dialog+
           :+type-dropdown_menu+
           :+type-popup_menu+
           :+type-tooltip+
           :+type-notificati
           :+type-combo+
           :+type-dnd+
           :+type-normal+
           :*cursors*
           :*debug-tk*
           :*debug-buffers*
           :*break-mainloop*
           :*exit-mainloop*
           :*init-wish-hook*
           :*mb-icons*
           :*nodgui-debug*
           :*tk*
           :*wish*
           :wish-stream
           :wish-variable
           :wish-variables
           :*wish-args*
           :*wish-pathname*
           :*default-nodgui-debugger*
           :add-pane
           :add-separator
           :after
           :after-cancel
           :after-idle
           :append-text
           :append-newline
           :ask-okcancel
           :ask-yesno
           :background
           :bbox
           :bell
           :bind
           :button
           :calc-scroll-region
           :canvas
           :canvas-line
           :canvas-oval
           :canvas-polygon
           :canvas-rectangle
           :canvas-text
           :canvas-image
           :canvas-item
           :canvas-arc
           :canvas-bbox
           :canvas-item-bbox
           :bbox-min-x
           :bbox-max-x
           :bbox-min-y
           :bbox-max-y
           :canvas-window
           :canvasx
           :canvasy
           :cget
           :check-button
           :choose-color
           :choose-directory
           :clear-text
           :clear
           :clipboard-append
           :clipboard-clear
           :clipboard-get
           :combobox
           :command
           :coords
           :configure
           :create-arc
           :create-bitmap
           :create-image
           :create-line
           :create-line*
           :create-menu2
           :create-oval
           :create-polygon
           :create-rectangle
           :create-text
           :create-window
           :*debug-settings-table*
           :defargs
           :deiconify
           :destroy
           :do-execute
           :do-msg
           :entry
           :entry-select
           :exit-wish
           :event
           :event-x
           :event-y
           :event-keycode
           :event-char
           :event-mouse-button
           :event-root-x
           :event-root-y
           :event-width
           :event-height
           :focus
           :font-configure
           :font-create
           :font-delete
           :font-metrics
           :force-focus
           :forget-pane
           :format-wish
           :frame
           :geometry
           :get-open-file
           :get-save-file
           :grab
           :grab-release
           :busy-hold
           :busy-forget
           :grid
           :grid-columnconfigure
           :grid-configure
           :grid-forget
           :grid-rowconfigure
           :hscroll
           :iconify
           :iconwindow
           :icon-window
           :wm-attrib
           :wm-attrib-alpha
           :wm-attrib-fullscreen
           :wm-attrib-topmost
           :wm-attrib-type
           :wm-attrib-zoomed
           :image-load
           :image-setpixel
           :cursor-index
           :input-box
           :insert-object
           :interior
           :itembind
           :itemconfigure
           :itemdelete
           :itemmove
           :itemlower
           :itemraise
           :item-cget
           :label
           :labelframe
           :listbox
           :listbox-append
           :listbox-clear
           :listbox-delete
           :listbox-configure
           :listbox-get-selection
           :listbox-nearest
           :listbox-select
           :load-text
           :lower
           :mainloop
           :make-items
           :create-items
           :make-canvas
           :make-frame
           :make-image
           :make-label
           :make-menu
           :make-menubar
           :make-menubutton
           :make-scrollbar
           :make-scrolled-canvas
           :make-text
           :make-toplevel
           :make-line
           :make-oval
           :make-polygon
           :make-rectangle
           :master
           :maxsize
           :menu
           :menubar
           :menubutton
           :menucheckbutton
           :menu-delete
           :menuradiobutton
           :message
           :message-box
           :minsize
           :move
           :move-all
           :normalize
           :notebook
           :on-close
           :on-focus
           :pack
           :pack-forget
           :pack-forget-all
           :pack-propagate
           :paned-window
           :photo-image
           :*ping-interval-seconds*
           :place
           :place-forget
           :popup
           :postscript
           :process-events
           :radio-button
           :raise
           :read-event
           :resizable
           :sash-coord
           :sash-place
           :save-text
           :scale
           :screen-height
           :screen-height-mm
           :screen-mouse
           :screen-mouse-x
           :screen-mouse-y
           :screen-width
           :screen-width-mm
           :toplevel-pathname
           :scrollbar
           :scrolled-canvas
           :scrolled-frame
           :scrolled-listbox
           :scrolled-text
           :scrollregion
           :search-all-text
           :search-next-text
           :see
           :send-lazy
           :send-wish
           :set-coords
           :set-coords*
           :set-focus-next
           :set-geometry
           :set-geometry-wh
           :set-geometry-xy
           :set-wm-overrideredirect
           :spinbox
           :start-wish
           :tag-bind
           :tag-configure
           :text
           :textbox
           :tkobject
           :title
           :toplevel
           :value
           :options
           :vscroll
           :widget
           :widget-path
           :window-height
           :window-id
           :window-width
           :window-x
           :window-y
           :window-transient
           :make-nodgui-connection
           :widget-class-name
           :with-atomic
           :with-nodgui
           :call-with-nodgui
           :exit-with-remote-nodgui
           :with-modal-toplevel
           :with-remote-nodgui
           :with-widgets
           :withdraw
           :wm-forget
           :wm-manage
           :wm-title
           :wm-state
           :with-hourglass
           :notebook-index
           :notebook-add
           :notebook-tab
           :notebook-forget
           :notebook-hide
           :notebook-identify
           :notebook-select
           :notebook-events
           :notebook-enable-traversal
           :defwidget
           :progressbar
           :length
           :mode
           :maximum
           :phase
           :separator
           :sizegrip
           :treeview
           :treeview-delete
           :column-configure
           :children
           :treeview-focus
           :treeview-exists
           :dictionary-plist
           :treeview-insert
           :treeview-item
           :treeview-column
           :treeview-heading
           :treeview-move
           :treeitem
           :self
           :reset-scroll
           :scroll-to-top
           :tagbind
           :pane-configure
           :handle
           :column-values
           :listbox-insert
           :font-families
           :scrolled-treeview
           :treeview-get-selection
           :treeview-identify
           :treeview-identify-item
           :treeview-set-selection
           :items
           :image
           :demo))

(defpackage :nodgui.mw
  (:use
   :cl
   :nodgui.event-parser
   :nodgui)
  (:export
   :redraw-on-resize
   :history-entry
   :history
   :clear-history
   :treelist
   :treelist-has-children
   :treelist-children
   :treelist-name
   :treelist-select
   :entries
   :gtree
   :tooltip
   :show
   :clear
   :cancel-tooltip
   :popup-time
   :register-tooltip
   :schedule-tooltip
   :list-select
   :data
   :list-select-display
   :selected-elements
   :searchable-listbox
   :selected-index
   :entry))

(defpackage :nodgui-user
  (:use :common-lisp :nodgui))
