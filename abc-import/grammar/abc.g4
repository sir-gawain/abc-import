/*
# ABC notation 2.0 - simpleparse specification
#   This is a simpleparse EBNF created from the ABC 2.0 ABNF written
#     by Henrik Norbeck.
#   It has a few constructs added to allow parsing of legacy ABC (1.6 and 1.7)
#   This version is written by Tom Satter
#   Copyright 2004 2005 2006 2007 Tom Satter
#   Licensed under the GPL
#
*/

grammar abc;

abc_file   : (abc_tune | file_field | tex_line | EOL | text_line)* EOF;

abc_tune   : abc_header abc_music_line+ EOF;

tex_line   : '\\\\' any_text_string EOL;  /* deprecated - kept only for backward compatibility with abc2mtex */

text_line  : any_text* EOL; /* Free text between tunes. This is a catch_all rule - check for fields first! */

/* -------------------------------------------------------------------------------- */

abc_header     : field_number? title_fields header_fields* field_key;

abc_music_line : tune_field | tex_line | abc_line | EOL;

abc_line       : element+ EOL;

/* -------------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------------- */

title_fields  : tex_line* (field_title tex_line*)+;

file_field    : field_area | field_book | field_composer |
                 field_discography | field_file | field_group |
                 field_history | field_instruction | field_length |
                 header_field_meter | field_notes | field_origin | field_parts |
                 field_tempo | field_rhythm | field_source |
                 field_userdef_print | field_userdef_play | field_words |
                 field_transcription | field_key | unused_field;

header_fields : field_area | field_book | field_composer |
                 field_discography | field_file | field_group |
                 field_history | field_instruction | field_length |
                 header_field_meter | field_notes | field_origin | field_parts |
                 field_tempo | field_rhythm | field_source |
                 field_userdef_print | field_userdef_play | field_voice |
                 field_words | field_transcription | field_macro |
                 unused_field | tex_line | EOL;

tune_field    : field_area | field_book | field_composer |
                 field_discography | field_group | field_history |
                 field_instruction | field_length | field_meter |
                 field_notes | field_origin | field_part | field_tempo |
                 field_rhythm | field_source | field_title |
                 field_voice | field_words | field_lyrics |
                 field_transcription | field_key | unused_field;

inline_field  : ifield_area | ifield_book | ifield_composer |
                 ifield_discography | ifield_group | ifield_history |
                 ifield_instruction | ifield_length | ifield_meter |
                 ifield_notes | ifield_origin | ifield_part |
                 ifield_tempo | ifield_rhythm | ifield_source |
                 ifield_title | ifield_voice | ifield_words |
                 ifield_lyrics | ifield_transcription | ifield_key;

/* -------------------------------------------------------------------------------- */

field_number         :  'X:'  (WSP|LC)? integer (WSP|LC)? EOL;
field_title          :  'T:'  (WSP|LC)? any_text_string EOL;
ifield_title         : '[T:'  (WSP|LC)? any_text_ifield ']';
field_area           :  'A:'  (WSP|LC)? any_text_string EOL;
ifield_area          : '[A:'  (WSP|LC)? any_text_ifield ']';
field_book           :  'B:'  (WSP|LC)? any_text_string EOL;
ifield_book          : '[B:'  (WSP|LC)? any_text_ifield ']';
field_composer       :  'C:'  (WSP|LC)? any_text_string EOL;
ifield_composer      : '[C:'  (WSP|LC)? any_text_ifield ']';
field_discography    :  'D:'  (WSP|LC)? any_text_string EOL;
ifield_discography   : '[D:'  (WSP|LC)? any_text_ifield ']';
field_file           :  'F:'  (WSP|LC)? any_text_string EOL;
field_group          :  'G:'  (WSP|LC)? any_text_string EOL;
ifield_group         : '[G:'  (WSP|LC)? any_text_ifield ']';
field_history        :  'H:'  (WSP|LC)? any_text_string EOL;
ifield_history       : '[H:'  (WSP|LC)? any_text_ifield ']';
field_instruction    :  'I:'  (WSP|LC)? instruction (WSP|LC)? EOL;
ifield_instruction   : '[I:'  (WSP|LC)? iinstruction (WSP|LC)? ']';
field_key            :  'K:'  (WSP|LC)? key (WSP|LC)? EOL;
ifield_key           : '[K:'  (WSP|LC)? key (WSP|LC)? ']';
field_length         :  'L:'  (WSP|LC)? note_length_strict (WSP|LC)? EOL;
ifield_length        : '[L:'  (WSP|LC)? note_length_strict ']';
header_field_meter   :  'M:'  (WSP|LC)? time_signature (WSP|LC)? EOL;
field_meter          :  'M:'  (WSP|LC)? time_signature (WSP|LC)? EOL;
ifield_meter         : '[M:'  (WSP|LC)? time_signature ']';
field_notes          :  'N:'  (WSP|LC)? any_text_string EOL;
ifield_notes         : '[N:'  (WSP|LC)? any_text_ifield ']';
field_origin         :  'O:'  (WSP|LC)? any_text_string EOL;
ifield_origin        : '[O:'  (WSP|LC)? any_text_ifield ']';
field_parts          :  'P:'  (WSP|LC)? parts_play_order (WSP|LC)? EOL;
field_part           :  'P:'  (WSP|LC)? LETTER (WSP|LC)? EOL;
ifield_part          : '[P:'  (WSP|LC)? LETTER (WSP|LC)? ']';
field_tempo          :  'Q:'  (WSP|LC)? tempo_def (WSP|LC)? EOL;
ifield_tempo         : '[Q:'  (WSP|LC)? tempo_def (WSP|LC)? ']';
field_rhythm         :  'R:'  (WSP|LC)? any_text_string EOL;
ifield_rhythm        : '[R:'  (WSP|LC)? any_text_ifield ']';
field_source         :  'S:'  (WSP|LC)? any_text_string EOL;
ifield_source        : '[S:'  (WSP|LC)? any_text_ifield ']';
field_userdef_print  :  'U:'  (WSP|LC)? userdef (WSP|LC)? EOL;
field_userdef_play   :  'u:'  (WSP|LC)? userdef (WSP|LC)? EOL;
field_voice          :  'V:'  (WSP|LC)? voice (WSP|LC)? EOL;
ifield_voice         : '[V:'  (WSP|LC)? voiceref (WSP|LC)? ']';
field_words          :  'W:'  (WSP|LC)? any_text_string EOL;
ifield_words         : '[W:'  (WSP|LC)? any_text_ifield ']';
field_transcription  :  'Z:'  (WSP|LC)? any_text_string EOL;
ifield_transcription : '[Z:'  (WSP|LC)? any_text_ifield ']';
field_macro          :  'm:'  (WSP|LC)? any_text_string EOL;
field_lyrics         :  'w:'  (WSP|LC)? lyrics (WSP|LC)? EOL;
ifield_lyrics        : '[w:'  (WSP|LC)? any_text_ifield ']';
unused_field         :     UNUSED ':' any_text_string EOL;
unused_ifield        : '[' UNUSED ':' any_text_ifield ']';

UNUSED               : [EIJYva-ln-tx-z];

/* -------------------------------------------------------------------------------- */

time_signature     : 'C|' | 'C' | 'none' | meter_num | integer;
meter_sums         : integer ('+' integer)*;
meter_numerator    : ('(' meter_sums ')') | meter_sums;
meter_num          : meter_numerator '|' integer (WSP|LC meter_num)?;
                      /* e.g. 2|4  6|8  2+2+3|16  11|8  2|4 3|4  2+2+3|8 2+2+3+2+2+2|8 */
tempo_def          : ((STRING_DOUBLE_QUOTE? (WSP|LC)? tempo (WSP|LC)? STRING_DOUBLE_QUOTE?) | STRING_DOUBLE_QUOTE);
tempo              : (note_length_strict (WSP|LC note_length_strict)* (WSP|LC)? '=' (WSP|LC)? integer) | ('C' (WSP|LC)? '=' (WSP|LC)? integer) | integer;
                      /* e.g. 'adagio' 1|4=60 1|4 3|8 1|4 3|8 = 80 'allegro' 1|4=120 'con brio' */
note_length_strict : integer '|' integer;
key                : clef | (key_def (WSP|LC clef)?) | 'HP' | 'Hp';
key_def            : key_pitch (WSP|LC)? (modus)? (WSP|LC global_accidental)*;
key_pitch          : BASENOTE ('#' | 'b')?;
modus              : MAJOR | LYDIAN | IONIAN | MIXOLYDIAN | DORIAN | AEOLIAN | PHRYGIAN | LOCRIAN | MINOR;
global_accidental  : accidental BASENOTE; /* e.g. ^f =c _b */
parts_play_order   : ((LETTER integer) | LETTER | '.' | (('(' parts_play_order ')') integer) | ('(' parts_play_order ')'))+;
                      /* dots are ignored - for legibility only */

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

/* -------------------------------------------------------------------------------- */

voice           : voiceref (WSP|LC (clef | voice_name | voice_subname | voice_transpose | voice_stave | voice_merge | stem_dir | voice_prop_str | voice_prop_int ))*;
voiceref        : (LETTER | DIGIT)+;
voice_name      : ('name'|'nm')(WSP|LC)?'=' (WSP|LC)? STRING_DOUBLE_QUOTE;
voice_subname   : ('subname'|'sname'|'snm')(WSP|LC)?'=' (WSP|LC)? STRING_DOUBLE_QUOTE;
voice_transpose : 'transpose'(WSP|LC)?'=' (WSP|LC)? signed_integer;
voice_stave     : ('stave'|'stv')(WSP|LC)?'='(WSP|LC)? integer;
voice_merge     : 'merge';
voice_prop_str  : VOICE_PROP_NAME (WSP|LC)? '=' (WSP|LC)? STRING_DOUBLE_QUOTE;
voice_prop_int  : VOICE_PROP_NAME (WSP|LC)? '=' (WSP|LC)? signed_integer;
VOICE_PROP_NAME : [-A-Za-z0-9_:]+;
stem_dir        : ('stem'(WSP|LC)?'=')? (WSP|LC)? stem_dir_value;
stem_dir_value  : 'up' | 'down' | 'normal';
clef            : (('clef'(WSP|LC)?'=' (WSP|LC)? (CLEF_NOTE | clef_name | clef_unknown)) | clef_name) CLEF_LINE? clef_OCTAVE? (WSP|LC clef_attributes)*;
clef_OCTAVE     : '+8' | '-8';
CLEF_NOTE       : [GCFP];
clef_name       : 'treble' | 'alto' | 'tenor' | 'baritone' | 'bass' | 'mezzo' |
                   'soprano' | 'perc' | 'none'; /* Maybe also Doh1-4 Fa1-4 */
clef_unknown    : LETTER+;
CLEF_LINE       : [1-5];
clef_attributes : clef_middle | clef_transpose | clef_stafflines;
clef_middle     : M 'iddle'? '=' clef_pitch;
clef_transpose  : T 'ranspose'? '=' signed_integer;
clef_stafflines : S 'tafflines'? '=' integer;
clef_pitch      : BASENOTE OCTAVE?;

M               : [mM];
S               : [sS];
T               : [tT];

/* -------------------------------------------------------------------------------- */

userdef         : USERDEF_SYMBOL (WSP|LC)? '=' (WSP|LC)? (LONG_DECORATION | chord_or_text);
USERDEF_SYMBOL  : [H-Yh-w~];

/* -------------------------------------------------------------------------------- */
/*
# 4.20. Order of ABC constructs
#
# The order of ABC constructs is: <grace notes> <chord symbols>
# <annotations>|<decorations> (e.g. Irish roll staccato marker or
# up|downbow) <accidentals> <note> <OCTAVE> ''<note length>''
# i.e. ~^c'3 or even 'Gm7'v.=G2.
#
# Tie symbols '-' should come immediately after a note group but may
# be followed by a space i.e. =G2- . Open and close chord symbols
# [] should enclose entire note sequences (except for chord symbols)
# i.e.
#
# 'C'[CEGc]| or |'Gm7'[.=G^c']
#
# and open and close slur symbols () should do likewise i.e.
#
# 'Gm7'(v.=G2~^c'2)
*/

element           : WSP | LC | inline_field | barline | broken_rhythm |
                     stem | chord_or_text | grace_notes |
                     tuplet_start | voice_over_start |
                     voice_over_end | voice_over_rollback |
                     slur_begin | slur_end | hard_line_break |
                     multi_measure_rest | measure_repeat | nth_repeat |
                     end_nth_repeat | unused_char;

hard_line_break   : '!';
barline           : decorations? (invisible_barline | (':'* '['* '|'+ ']'* (':'+ | nth_repeat_num)?) | dashed_barline); /* e.g. :| | |:: |2 :||: */
invisible_barline : '[|]' | '[]';
dashed_barline    : ':';

/* -------------------------------------------------------------------------------- */

stem            : decorations? (singlenote | stemchord | rest | spacer);
singlenote      : note;
stemchord       : '[' note note+ ']' note_length? tie?;
note            : WSP? pitch note_length? tie? WSP?;
pitch           : accidental? BASENOTE OCTAVE?;
rest            : (normal_rest | invisible_rest ) note_length?;
normal_rest     : 'z';
invisible_rest  : 'x';
spacer          : 'y';
accidental      : '^^' | '^' | '__' | '_' | '=';
BASENOTE        : [CDEFGABcdefgab];
OCTAVE          : [']+;
note_length     : (integer ('|' integer)?) | ('|' integer) | '|'+;
tie             : '.-' | '-';

/* -------------------------------------------------------------------------------- */

broken_rhythm   : stem b_elem* broken_type b_elem* stem;
broken_type     : '<'+ | '>'+;
b_elem          : WSP | LC | chord_or_text | decorations | grace_notes | slur_begin | slur_end;
tuplet_start    : decorations? tuplet_num (tuplet_into tuplet_notes?)?;
tuplet_num      : '(' integer;
tuplet_into     : ':' integer?;
tuplet_notes    : ':' integer?;

/* -------------------------------------------------------------------------------- */

decorations     : decoration+;
decoration      : '.' | USERDEF_SYMBOL | LONG_DECORATION;
LONG_DECORATION : '+' [A-Za-z0-9().<>]+ '+';
grace_notes     : '{' acciaccatura? grace_note_stem+ '}';
grace_note_stem : grace_note | ('[' grace_note grace_note+ ']');
grace_note      : pitch note_length?;
acciaccatura    : '|';

/* -------------------------------------------------------------------------------- */

chord_or_text    : '\'' (chord | text_expression) (chord_newline (chord | text_expression))* '\'';
chord            : decorations? BASENOTE chord_accidental? chord_type? ('|' BASENOTE chord_accidental?)? non_quote*;
chord_accidental : '#' | 'b' | '=';
chord_type       : (LETTER | DIGIT | '+' | '-')+;
text_expression  : ('^' | '<' | '>' | '_' | '@')? non_quote+;
chord_newline    : '\n' | '#';

/* -------------------------------------------------------------------------------- */

slur_begin           : '(' | '.(';
slur_end             : ')' | '.)';

voice_over_start     : '(&';
voice_over_rollback  : '&';
voice_over_end       : '&)';

measure_repeat       : '|' '|'?;
multi_measure_rest   : decorations? 'Z' integer?;

nth_repeat           : '[' (nth_repeat_num | nth_repeat_text);
nth_repeat_num       : DIGITS (('' | '-') DIGITS)*;
nth_repeat_text      : STRING_DOUBLE_QUOTE;
end_nth_repeat       : ']';

unused_char          : '#' | '$' | '*' | '+' | '#' | '?' | '@' | '`';
                        /* ignore for backward and forward compatibility but maybe
                         warn about them */

/* ------------------ -------------------------------------------------------------- */

instruction          : inst_abc_copyright | inst_abc_version | inst_abc_creator |
                        inst_abc_charset | inst_abc_edited_by | inst_staff |
                        inst_measurenb | inst_text | inst_layout | inst_margins |
                        inst_midi | inst_other
                      ;

iinstruction         : iinst_abc_copyright | iinst_abc_version | iinst_abc_creator |
                        iinst_abc_charset | iinst_abc_edited_by | iinst_staff |
                        iinst_measurenb | iinst_text | iinst_layout | iinst_margins |
                        iinst_midi | iinst_other;

inst_abc_copyright   : 'abc-copyright' WSP|LC any_text_string;
iinst_abc_copyright  : 'abc-copyright' WSP|LC any_text_ifield;
inst_abc_version     : 'abc-version' WSP|LC DIGITS ('.' DIGITS)*;
iinst_abc_version    : inst_abc_version;
inst_abc_creator     : 'abc-creator' WSP|LC any_text_string;
iinst_abc_creator    : 'abc-creator' WSP|LC any_text_ifield;
inst_abc_charset     : 'abc-charset' WSP|LC any_text_string;
iinst_abc_charset    : 'abc-charset' WSP|LC any_text_ifield;
inst_abc_edited_by   : 'abc-edited-by' WSP|LC any_text_string;
iinst_abc_edited_by  : 'abc-edited-by' WSP|LC any_text_ifield;
inst_staff           : inst_staffbreak | inst_multicol | inst_staves | inst_indent;
iinst_staff          : inst_staff;
inst_measurenb       : 'measurenb' | 'measurebox' | 'measurefirst' | ('setbarnb' WSP|LC DIGITS);
iinst_measurenb      : inst_measurenb;
inst_text            : inst_textline | inst_textcenter | inst_textblock;
iinst_text           : iinst_textline | iinst_textcenter | iinst_textblock;
inst_textline        : 'text' WSP|LC any_text_string;
iinst_textline       : 'text' WSP|LC any_text_ifield;
inst_textcenter      : 'center' WSP|LC any_text_string;
iinst_textcenter     : 'center' WSP|LC any_text_ifield;
inst_textblock       : 'begintext' (WSP|LC textblock_param)? (WSP|LC)? EOL
                        ('I:' (WSP|LC)? ? ('endtext'(WSP|LC)?EOL) any_text_string EOL)*
                        'I:' (WSP|LC)? 'endtext';
iinst_textblock      : 'begintext' (WSP|LC textblock_param)? (WSP|LC)? ']'  (WSP|LC)?
                        ('[I:' (WSP|LC)? ? ('endtext'(WSP|LC)?']') any_text_ifield ']' (WSP|LC)?)*
                        '[I:' (WSP|LC)? 'endtext';
inst_layout          : inst_sep | inst_vskip | inst_newpage;
iinst_layout         : inst_layout;
inst_margins         : ('botmargin' | 'topmargin' | 'leftmargin' | 'rightmargin') WSP|LC midi_float inst_unit;
iinst_margins        : inst_margins;
inst_midi            : 'midi' WSP|LC (midi_channel | midi_program | midi_transpose | midi_control | midi_voice | midi_instrument | midi_mute | midi_chordprog )+;
iinst_midi           : inst_midi;
inst_other           : any_text_string;
iinst_other          : any_text_ifield;

inst_staffbreak      : 'staffbreak' WSP|LC midi_float inst_unit;
inst_multicol        : 'multicol' WSP|LC ('start' | 'new' | 'end');
inst_staves          : 'staves' WSP|LC stave_voice ((WSP|LC)? bar_staves? stave_voice)*;
stave_voice          : single_voice | bracketed_voice | braced_voice | paren_voice;
bracketed_voice      : '[' (WSP|LC)? (single_voice | braced_voice | paren_voice)
                         ((WSP|LC)? bar_staves? (single_voice | braced_voice | paren_voice))+ (WSP|LC)?']'; /* staves joined by bracket */
braced_voice         : '{' (WSP|LC)? (single_voice | paren_voice)
                         ((WSP|LC)? bar_staves? (single_voice | paren_voice))+ (WSP|LC)? '}'; /* staves joined by brace */
paren_voice          : '(' single_voice ((WSP|LC)? bar_staves? single_voice)+ ')'; /* on same staff */
single_voice         : '*'? (LETTER | DIGIT)+;
bar_staves           : '|' (WSP|LC)?;
inst_indent          : 'indent' WSP|LC midi_float inst_unit;
textblock_param      : 'obeylines' | 'fill' | 'ragged' | 'align' | 'justify' | 'skip';
inst_sep             : 'sep' ((WSP|LC midi_float inst_unit) (WSP|LC midi_float inst_unit) (WSP|LC midi_float inst_unit))?;
                        /* space_above space_below width */
inst_vskip           : 'vskip' WSP|LC midi_float inst_unit;
inst_newpage         : 'newpage' (WSP|LC DIGITS)?; /* optionally restart page numbering at n */
midi_channel         : 'channel' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC MIDI_CHANNEL_NUMBER (WSP|LC)?;
midi_program         : 'program' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC (MIDI_CHANNEL_NUMBER ((WSP|LC)? '' (WSP|LC)?) | WSP|LC midi_program_number) | midi_program_number (WSP|LC)?;
midi_control         : 'control' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC (integer ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC integer) | midi_control_int | midi_control_bool (WSP|LC)?;
MIDI_CHANNEL_NUMBER  : ('1' [0-6]) | [1-9];
midi_program_number  : MP_NUM | midi_program_name;
MP_NUM               : (('1' [01] [0-9]) | ('12' [0-8]) | ([1-9] [0-9]) | [1-9]);
midi_program_name    : 'Acoustic Grand' | 'Bright Acoustic' | 'Electric Grand' | 'Honky-Tonk' | 'Electric Piano 1' | 'Electric Piano 2' |
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
midi_percussion_name : 'Acoustic Bass Drum' | 'Bass Drum 1' | 'Side Stick' | 'Acoustic Snare' | 'Hand Clap' |
                        'Electric Snare' | 'Low Floor Tom' | 'Closed Hi-Hat' | 'High Floor Tom' | 'Pedal Hi-Hat' |
                        'Low Tom' | 'Open Hi-Hat' | 'Low-Mid Tom' | 'Hi-Mid Tom' | 'Crash Cymbal 1' | 'High Tom' |
                        'Ride Cymbal 1' | 'Chinese Cymbal' | 'Ride Bell' | 'Tambourine' | 'Splash Cymbal' |
                        'Cowbell' | 'Crash Cymbal 2' | 'Vibraslap' | 'Ride Cymbal 2' | 'Hi Bongo' | 'Low Bongo' |
                        'Mute Hi Conga' | 'Open Hi Conga' | 'Low Conga' | 'High Timbale' | 'Low Timbale' |
                        'High Agogo' | 'Low Agogo' | 'Cabasa' | 'Maracas' | 'Short Whistle' | 'Long Whistle' |
                        'Short Guiro' | 'Long Guiro' | 'Claves' | 'Hi Wood Block' | 'Low Wood Block' |
                        'Mute Cuica' | 'Open Cuica' | 'Mute Triangle' | 'Open Triangle';
midi_transpose       : 'transpose' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC signed_integer (WSP|LC)?;
midi_voice           : 'voice' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC midi_voiceref (WSP|LC)?;
midi_voiceref        : (LETTER | DIGIT)+;
midi_instrument      : 'instrument' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC midi_program_number (WSP|LC)? (midi_bank)? (WSP|LC)?;
midi_bank            : 'bank' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC integer (WSP|LC)?;
midi_mute            : 'mute' (WSP|LC)?;
midi_chordprog       : 'chordprog' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC midi_program_number (WSP|LC)?;
midi_control_int     : midi_control_volume | midi_control_balance | midi_control_pan;
midi_control_volume  : 'volume' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC (integer | midi_volume_label);
midi_volume_label    : 'fff' 'ff' 'f' 'mf' 'm' 'mp' 'p' 'pp' 'ppp';
midi_control_balance : 'balance' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC (integer | midi_pan_label);
midi_control_pan     : 'pan' ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC (integer | midi_pan_label);
midi_pan_label       : 'far left' | 'left' | 'mid-left' | 'center' | 'mid-right' | 'right' | 'far right';
midi_control_bool    : midi_bool_name ((WSP|LC)? '=' (WSP|LC)?) | WSP|LC bool;
midi_bool_name       : 'sustain' | 'portamento' | 'sostenuto' | 'soft pedal' | 'legato' | 'omni' | 'poly' | 'mono';
inst_unit            : ('cm' | 'pt' | 'in')?;
integer              : DIGITS;
bool                 : '0' | '1' | 'on' | 'off' | 'true' | 'false';
signed_integer       : ('+' | '-')? DIGITS;
midi_float           : (DIGITS ('.' DIGITS)?) | ('.' DIGITS);

/* -------------------------------------------------------------------------------- */

lyrics                : (lyrics_char | lyrics_syllable_break | lyrics_next_bar |
                         lyrics_hold | lyrics_skip_note | lyrics_nbsp | lyrics_dash |
                         tex_escape)*;
lyrics_ifield         : (lyrics_char_ifield | lyrics_syllable_break |
                         lyrics_next_bar | lyrics_hold | lyrics_skip_note |
                         lyrics_nbsp | lyrics_dash | tex_escape)*;
lyrics_syllable_break : '-'; /* break between syllables in a word */
lyrics_next_bar       : '|'; /* advance to next bar */
lyrics_hold           : '_'; /* hold syllable for one more note */
lyrics_skip_note      : '*'; /* =blank syllable */
lyrics_nbsp           : '~'; /* non_breaking space = words on same note */
lyrics_dash           : '\\-'; /* printed as a - */
lyrics_char_ifield    : WSP_internal | DIGIT | LETTER | SPECIAL | LX1;
                         /* all characters without special meaning and except ']' */
lyrics_char           : lyrics_char_ifield | ']';
                         /* all characters without special meaning */

LX1                   : [!'#$%&'()+.|:;<=>?@[^`{|}];

/* -------------------------------------------------------------------------------- */

QUOTE: '"';
fragment ESC :   '\\' (["\\/bfnrt] | UNICODE) ;
fragment UNICODE : 'u' HEX HEX HEX HEX ;
fragment HEX : [0-9a-fA-F] ;

SPECIAL         : '\\' ([`^'\'=;.vuanso~:|] [a-zA-Z]) | '\\\\' | '\\[';
non_quote       : (WSP_internal | LX2);       /* all non_eol characters except double quote */
any_text        : (WSP_internal | SPECIAL | LX3); /* any printable character plus all non_eol whitespace */
non_bracket     : (WSP_internal | SPECIAL | LX4); /* any character except closing bracket */
any_text_string : any_text*;                         /* string of any_text */
any_text_ifield : (non_bracket)*; /* as above but except ] */
tex_escape      : '\\' (DIGIT | LETTER | '_')+;     /* tex line - for backward compatability */
LX2: [\x21\x23-\x7E];
LX3: [\x21-\x7E];
LX4: [\x21-\x5C\x5E-\x7E];

STRING_DOUBLE_QUOTE: QUOTE (ESC | ~["\\])* QUOTE;

fragment DIGIT:   ('0'..'9');
fragment DIGITS:  DIGIT+;
fragment PDIGIT:  ('1'..'9');

fragment LETTER:
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

/* -------------------------------------------------------------------------------- */

comment : '%' any_text_string;
LC      : WSP_internal* '\\' WSP_internal* EOL WSP_internal*;
eol     : comment? EOL;

/* -------------------------------------------------------------------------------- */

EOL           : CRLF | LF | CR;
CRLF          : '\r\n';
LF            : '\n';
CR            : '\r';
WSP           : WSP_internal+;
WSP_internal  : [\t\b\f\v];

/* -------------------------------------------------------------------------------- */
