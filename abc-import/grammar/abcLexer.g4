lexer grammar abcLexer;

X:  'X:';
T:  'T:' -> pushMode(AnyText);
A:  'A:' { this.column == 2 }? -> pushMode(AnyText);
B:  'B:' { this.column == 2 }? -> pushMode(AnyText);
C:  'C:' { this.column == 2 }? -> pushMode(AnyText);
D:  'D:' { this.column == 2 }? -> pushMode(AnyText);
F:  'F:' { this.column == 2 }? -> pushMode(AnyText);
G:  'G:' { this.column == 2 }? -> pushMode(AnyText);
H:  'H:' { this.column == 2 }? -> pushMode(AnyText);
I:  'I:';
K:  'K:';
L:  'L:';
M:  'M:';
N:  'N:' -> pushMode(AnyText);
O:  'O:' -> pushMode(AnyText);
P:  'P:' -> pushMode(Part);
Q:  'Q:';
R:  'R:' -> pushMode(AnyText);
S:  'S:' -> pushMode(AnyText);
U:  'U:' -> pushMode(UserDef);
FU: 'u:' -> pushMode(UserDef);
V:  'V:';
W:  'W:' -> pushMode(AnyText);
Z:  'Z:' -> pushMode(AnyText);
FM: 'm:' -> pushMode(AnyText);
FW: 'w:' -> pushMode(Lyrics);

IT:  '[T:' -> pushMode(AnyTextIField);
IA:  '[A:' -> pushMode(AnyTextIField);
IB:  '[B:' -> pushMode(AnyTextIField);
IC:  '[C:' -> pushMode(AnyTextIField);
ID:  '[D:' -> pushMode(AnyTextIField);
IF:  '[F:' -> pushMode(AnyTextIField);
IG:  '[G:' -> pushMode(AnyTextIField);
IH:  '[H:' -> pushMode(AnyTextIField);
II:  '[I:';
IK:  '[K:';
IL:  '[L:';
IM:  '[M:';
IN:  '[N:' -> pushMode(AnyTextIField);
IO:  '[O:' -> pushMode(AnyTextIField);
IP:  '[P:' -> pushMode(Part);
IQ:  '[Q:';
IR:  '[R:' -> pushMode(AnyTextIField);
IS:  '[S:' -> pushMode(AnyTextIField);
IU:  '[U:' -> pushMode(UserDef);
IFU: '[u:' -> pushMode(UserDef);
IV:  '[V:';
IW:  '[W:' -> pushMode(AnyTextIField);
IZ:  '[Z:' -> pushMode(AnyTextIField);
IFM: '[m:' -> pushMode(AnyTextIField);
IFW: '[w:' -> pushMode(Lyrics);

SX: 'x';
SY: 'y';
SZ: 'z';
//UNUSED               : [EIJYva-ln-tx-z];

WSP_INTERNAL  : [\t\b\f] -> channel(HIDDEN);
WSP           : WSP_INTERNAL+ -> channel(HIDDEN);

LC      : WSP_INTERNAL* '\\' WSP_INTERNAL* EOL WSP_INTERNAL*  -> channel(HIDDEN);

ABC                : '%abc';

NONE               : 'none';

MINOR              : [mM] ('in' ([oO] ([rR])?)?)?;
                      /* m min mino minor - all modes are case insensitive */
MAJOR              : 'maj' ([oO] ([rR])?)?;
LYDIAN             : 'lyd' ([iI] ([aA] ([nN])?)?)?; /* major with sharp 4th */
IONIAN             : 'ion' ([iI] ([aA] ([nN])?)?)?; /* =major */
MIXOLYDIAN         : 'mix' ([oO] ([lL] ([yY] ([dD] ([iI] ([aA] ([nN])?)?)?)?)?)?)?; /* major with flat 7th */
DORIAN             : 'dor' ([iI] ([aA] ([nN])?)?)?; /* minor with sharp 6th */
AEOLIAN            : 'aeo' ([lL] ([iI] ([aA] ([nN])?)?)?)?; /* =minor */
PHRYGIAN           : 'phr' ([yY] ([gG] ([iI] ([aA] ([nN])?)?)?)?)?; /* minor with flat 2nd */
LOCRIAN            : 'loc' ([rR] ([iI] ([aA] ([nN])?)?)?)?; /* minor with flat 2nd and 5th */

LONG_DECORATION    : PLUS [A-Za-z0-9().<>]+ PLUS;

BOOL               : 'on' | 'off' | 'true' | 'false';

HP:                  'HP' | 'Hp';

SMALL_B         : 'b';
BASENOTE        : [CDEFGABcdefga];
OCTAVE          : [',]+;

CLEF            : 'clef';
CLEF_NAME       : 'treble' | 'alto' | 'tenor' | 'baritone' | 'bass' | 'mezzo' | 'soprano' | 'perc' | 'none';
/*CLEF_LINE       : [1-5];*/
CLEF_NOTE       : [GCFP];
CLEF_OCTAVE     : '+8' | '-8';
STEM_DIR_VALUE  : 'up' | 'down' | 'normal';

INVISIBLE_BARLINE    : '[|]' | '[]';

TIME_SIG             : 'C|' | 'C';
MIDDLE               : 'Middle' | 'middle';
TRANSPOSE            : 'Transpose' | 'transpose';
STAFFLINES           : 'Stafflines' | 'stafflines';

VOICE_MERGE          : 'merge';
VOICE_NAME           : ('name'|'nm');
VOICE_SUBNAME        : ('subname'|'sname'|'snm');
VOICE_TRANSPOSE      : 'transpose';
VOICE_STAVE          : ('stave'|'stv');
STEM                 : 'stem';
/*VOICE_PROP_NAME : NORM_STRING;*/
VOICE_OVER_START     : '(&';
VOICE_OVER_ROLLBACK  : '&';
VOICE_OVER_END       : '&)';

ABC_COPYRIGHT        : 'ABC_COPYRIGHT';
ABC_VERSION          : 'abc_version';
ABC_CREATOR          : 'abc_creator';
ABC_CHARSET          : 'abc_charset';
ABC_EDITED_BY        : 'abc_edited_by';
MEASURENB            : 'measurenb';
MEASUREBOX           : 'measurebox';
MEASUREFIRST         : 'measurefirst';
SETBARNB             : 'setbarnb';
TEXT                 : 'text';
CENTER               : 'center';
BEGINTEXT            : 'begintext';
ENDTEXT              : 'endtext';
BOTMARGIN            : 'botmargin';
TOPMARGIN            : 'topmargin';
LEFTMARGIN           : 'leftmargin';
RIGHTMARGIN          : 'rightmargin';
STAFFBREAK           : 'staffbreak';
MULTICOL             : 'multicol';
START                : 'start';
NEW                  : 'new';
END                  : 'end';
STAVES               : 'staves';
INDENT               : 'indent';
TEXTBLOCK_PARAM      : 'obeylines' | 'fill' | 'ragged' | 'align' | 'justify' | 'skip';
SEP                  : 'sep';
VSKIP                : 'vskip';
NEWPAGE              : 'newpage';
INST_UNIT            : 'cm' | 'pt' | 'in';

MIDI                 : 'midi' -> pushMode(Midi);

SPECIAL              : '\\' ([`^'=;.vuanso~:|] [a-zA-Z]) | '\\\\' | '\\[';

INTEGER              : DIGIT+;
SIGNED_INTEGER       : (PLUS | MINUS)? DIGIT+;

DIGIT                : ('0'..'9');
DIGITS:  DIGIT+;

HARD_LINE_BREAK   : '!';

QUOTE:   '"'; // -> pushMode(DoubleString);
PLUS:    '+';
MINUS:   '-' | '–';
TIMES:   '*';
SLASH:  '/';
LPAREN:  '(';
RPAREN:  ')';
LBPAREN: '[';
RBPAREN: ']';
LCBRACK: '{';
RCBRACK: '}';
DEGREE:  '°' | 'º';
MINUTE:  '\'';
TICK:    '`';
DOT:     '.';
COMMA:   ',';
POW:     '^';
PIPE:    '|';
COLON:   ':';
LT:      '<';
GT:      '>';
AT:      '@';
EQUAL:   '=';
HASH:    '#';
DOLLAR:  '$';
QUESTION:'?';
UNDERSCORE: '_';
DOUBLE_BACKSLASH: '\\\\' -> pushMode(AnyText);
BACKSLASH:   '\\';
TILDE:   '~';
SPC:     ( '\t' | ' ' | '\u000C' )+ -> channel(HIDDEN);
EOL: ('\r' | '\n' | '\r' '\n');

COMMENT_START:  '%' -> pushMode(Comment);

LX2: [!#-~];
LX3: [!-~];
LX4: [!-\\^-~];

DECIMAL:  DIGIT+ (',' | '.') DIGIT+;

/*NORM_STRING: [-A-Za-z0-9_:]+; */

LETTER:
        '\u0024' |
        '\u0041'..'\u005a' |
        '\u005f' |
        '\u0061'..'\u007a' |
        '\u00c0'..'\u00d6' |
        '\u00d8'..'\u00f6' |
        '\u00f8'..'\u00ff' |
        '\u0100'..'\u1fff' |
        '\u3040'..'\u318f' |
        '\u3300'..'\u337f' |
        '\u3400'..'\u3d2d' |
        '\u4e00'..'\u9fff' |
        '\uf900'..'\ufaff'
    ;

//NORM_STRING: LETTER+;

INVALID: .;

mode Comment;

COMMENT:    ~[\n\r]+ -> popMode;

mode AnyText;

ANY_TEXT_STRING:     ~[\n\r]+ -> popMode;

mode AnyTextIField;

ANY_TEXT_IFIELD:     ~[\]\n\r]+ ']' -> popMode;

mode Part;

PART_NUMBER:     ~[\]\n\r]+ ']' -> popMode;

mode Lyrics;

L_MINUS         : '-';
L_PIPE          : '|';
L_UNDERSCORE    : '_';
L_TIMES         : '*';
L_TILDE         : '~';
L_LDASH         : '\\-';
L_WSP_INTERNAL  : [\t\b\f] -> channel(HIDDEN);
L_SPECIAL       : '\\' ([`^'=;.vuanso~:|] [a-zA-Z]) | '\\\\' | '\\[';
L_LX1           : [!"#$%&'()+,./:;<=>?@[^`{|}];
L_RBPAREN       : ']';
L_DIGIT         : ('0'..'9');
L_SPC           : ( '\t' | ' ' | '\u000C' )+ -> channel(HIDDEN);
L_EOL           : [\n\r]+ -> popMode,type(EOL);
L_LETTER        :
        '\u0024' |
        '\u0041'..'\u005a' |
        '\u005f' |
        '\u0061'..'\u007a' |
        '\u00b4' |
        '\u00c0'..'\u00d6' |
        '\u00d8'..'\u00f6' |
        '\u00f8'..'\u00ff' |
        '\u0100'..'\u1fff' |
        '\u3040'..'\u318f' |
        '\u3300'..'\u337f' |
        '\u3400'..'\u3d2d' |
        '\u4e00'..'\u9fff' |
        '\uf900'..'\ufaff'
    ;

mode DoubleString;

STRING_DOUBLE_QUOTE_QUOTE: '"' -> popMode;
STRING_DOUBLE_QUOTE : ~["\n\r]+;

mode Midi;

VOICE                : 'voice';
INSTRUMENT           : 'instrument';
BANK                 : 'bank';
MUTE                 : 'mute';
CHANNEL              : 'channel';
PROGRAM              : 'program';
CONTROL              : 'control';
CHORDPROG            : 'chordprog';
VOLUME               : 'volume';
BALANCE              : 'balance';
PAN                  : 'pan';

MIDI_VOLUME_LABEL    : 'fff' 'ff' 'f' 'mf' 'm' 'mp' 'p' 'pp' 'ppp';
MIDI_PAN_LABEL       : 'far left' | 'left' | 'mid-left' | 'center' | 'mid-right' | 'right' | 'far right';
MIDI_BOOL_NAME       : 'sustain' | 'portamento' | 'sostenuto' | 'soft pedal' | 'legato' | 'omni' | 'poly' | 'mono';
MIDI_PROGRAM_NAME    : 'Acoustic Grand' | 'Bright Acoustic' | 'Electric Grand' | 'Honky-Tonk' | 'Electric Piano 1' | 'Electric Piano 2' |
                        'Harpsichord' | 'Clavinet' | 'Celesta' | 'Glockenspiel' | 'Music Box' | 'Vibraphone' | 'Marimba' | 'Xylophone' |
                        'Tubular Bells' | 'Dulcimer' | 'Drawbar Organ' | 'Percussive Organ' | 'Rock Organ' | 'Church Organ' | 'Reed Organ' |
                        'Accoridan' | 'Harmonica' | 'Tango Accordian' | 'Nylon String Guitar' | 'Steel String Guitar' |
                        'Electric Jazz Guitar' | 'Electric Clean Guitar' | 'Electric Muted Guitar' | 'Overdriven Guitar' |
                        'Distortion Guitar' | 'Guitar Harmonics' | 'Acoustic Bass' | 'Electric Bass(finger)' | 'Electric Bass(pick)' |
                        'Fretless Bass' | 'Slap Bass 1' | 'Slap Bass 2' | 'Synth Bass 1' | 'Synth Bass 2' | 'Violin' | 'Viola' |
                        'Cello' | 'Contrabass' | 'Tremolo Strings' | 'Pizzicato Strings' | 'Orchestral Strings' | 'Timpani' |
                        'String Ensemble 1' | 'String Ensemble 2' | 'SynthStrings 1' | 'SynthStrings 2' | 'Choir Aahs' | 'Voice Oohs' |
                        'Synth Voice' | 'Orchestra Hit' | 'Trumpet' | 'Trombone' | 'Tuba' | 'Muted Trumpet' | 'French Horn' |
                        'Brass Section' | 'SynthBrass 1' | 'SynthBrass 2' | 'Soprano Sax' | 'Alto Sax' | 'Tenor Sax' | 'Baritone Sax' |
                        'Oboe' | 'English Horn' | 'Bassoon' | 'Clarinet' | 'Piccolo' | 'Flute' | 'Recorder' | 'Pan Flute' |
                        'Blown Bottle' | 'Skakuhachi' | 'Whistle' | 'Ocarina' | 'Lead 1 (square)' | 'Lead 2 (sawtooth)' |
                        'Lead 3 (calliope)' | 'Lead 4 (chiff)' | 'Lead 5 (charang)' | 'Lead 6 (voice)' | 'Lead 7 (fifths)' |
                        'Lead 8 (bass+lead)' | 'Pad 1 (new age)' | 'Pad 2 (warm)' | 'Pad 3 (polysynth)' | 'Pad 4 (choir)' |
                        'Pad 5 (bowed)' | 'Pad 6 (metallic)' | 'Pad 7 (halo)' | 'Pad 8 (sweep)' | 'FX 1 (rain)' | 'FX 2 (soundtrack)' |
                        'FX 3 (crystal)' | 'FX 4 (atmosphere)' | 'FX 5 (brightness)' | 'FX 6 (goblins)' | 'FX 7 (echoes)' |
                        'FX 8 (sci-fi)' | 'Sitar' | 'Banjo' | 'Shamisen' | 'Koto' | 'Kalimba' | 'Bagpipe' | 'Fiddle' | 'Shanai' |
                        'Tinkle Bell' | 'Agogo' | 'Steel Drums' | 'Woodblock' | 'Taiko Drum' | 'Melodic Tom' | 'Synth Drum' |
                        'Reverse Cymbal' | 'Guitar Fret Noise' | 'Breath Noise' | 'Seashore' | 'Bird Tweet' | 'Telephone Ring' |
                        'Helicopter' | 'Applause' | 'Gunshot';
MIDI_PERCUSSION_NAME : 'Acoustic Bass Drum' | 'Bass Drum 1' | 'Side Stick' | 'Acoustic Snare' | 'Hand Clap' |
                        'Electric Snare' | 'Low Floor Tom' | 'Closed Hi-Hat' | 'High Floor Tom' | 'Pedal Hi-Hat' |
                        'Low Tom' | 'Open Hi-Hat' | 'Low-Mid Tom' | 'Hi-Mid Tom' | 'Crash Cymbal 1' | 'High Tom' |
                        'Ride Cymbal 1' | 'Chinese Cymbal' | 'Ride Bell' | 'Tambourine' | 'Splash Cymbal' |
                        'Cowbell' | 'Crash Cymbal 2' | 'Vibraslap' | 'Ride Cymbal 2' | 'Hi Bongo' | 'Low Bongo' |
                        'Mute Hi Conga' | 'Open Hi Conga' | 'Low Conga' | 'High Timbale' | 'Low Timbale' |
                        'High Agogo' | 'Low Agogo' | 'Cabasa' | 'Maracas' | 'Short Whistle' | 'Long Whistle' |
                        'Short Guiro' | 'Long Guiro' | 'Claves' | 'Hi Wood Block' | 'Low Wood Block' |
                        'Mute Cuica' | 'Open Cuica' | 'Mute Triangle' | 'Open Triangle';
MIDI_CHANNEL_NUMBER  : ('1' [0-6]) | [1-9];
MP_NUM               : (('1' [01] [0-9]) | ('12' [0-8]) | ([1-9] [0-9]) | [1-9]);
MIDI_EOL             : [\n\r]+ -> popMode, type(EOL);

mode UserDef;

USERDEF_SYMBOL  : [H-Yh-w~];
