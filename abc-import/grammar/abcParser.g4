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

parser grammar abcParser;

options {
  tokenVocab=abcLexer;
}

/* -------------------------------------------------------------------------------- */

abc_file   : abc_file_header? ( abc_tune | file_field | tex_line | eol | text_line)+ EOF;

abc_tune   : abc_header abc_music_line+;

tex_line   : DOUBLE_BACKSLASH ANY_TEXT_STRING eol;  /* deprecated - kept only for backward compatibility with abc2mtex */

text_line  : any_text* eol; /* Free text between tunes. This is a catch_all rule - check for fields first! */

/* -------------------------------------------------------------------------------- */

abc_file_header: ABC (MINUS DECIMAL)?;

/* -------------------------------------------------------------------------------- */

abc_header     : field_number? title_fields header_fields* field_key;

abc_music_line : tune_field | tex_line | abc_line | eol;

abc_line       : element+ eol;

/* -------------------------------------------------------------------------------- */

title_fields  : tex_line* (field_title tex_line*)+;

file_field    : field_area | field_book | field_composer |
                 field_discography | field_file | field_group |
                 field_history | field_instruction | field_length |
                 header_field_meter | field_notes | field_origin | field_parts |
                 field_tempo | field_rhythm | field_source |
                 field_userdef_print | field_userdef_play | field_words |
                 field_transcription | field_key /*| unused_field*/;

header_fields : field_area | field_book | field_composer |
                 field_discography | field_file | field_group |
                 field_history | field_instruction | field_length |
                 header_field_meter | field_notes | field_origin | field_parts |
                 field_tempo | field_rhythm | field_source |
                 field_userdef_print | field_userdef_play | field_voice |
                 field_words | field_transcription | field_macro |
                 /*unused_field |*/ tex_line | eol;

tune_field    : field_area | field_book | field_composer |
                 field_discography | field_group | field_history |
                 field_instruction | field_length | field_meter |
                 field_notes | field_origin | field_part | field_tempo |
                 field_rhythm | field_source | field_title |
                 field_voice | field_words | field_lyrics |
                 field_transcription | field_key /*| unused_field*/;

inline_field  : ifield_area | ifield_book | ifield_composer |
                 ifield_discography | ifield_group | ifield_history |
                 ifield_instruction | ifield_length | ifield_meter |
                 ifield_notes | ifield_origin | ifield_part |
                 ifield_tempo | ifield_rhythm | ifield_source |
                 ifield_title | ifield_voice | ifield_words |
                 ifield_lyrics | ifield_transcription | ifield_key;

/* -------------------------------------------------------------------------------- */

field_number         :   X  INTEGER eol;
field_title          :   T  ANY_TEXT_STRING eol;
ifield_title         :  IT  ANY_TEXT_IFIELD;
field_area           :   A  ANY_TEXT_STRING eol;
ifield_area          :  IA  ANY_TEXT_IFIELD;
field_book           :   B  ANY_TEXT_STRING eol;
ifield_book          :  IB  ANY_TEXT_IFIELD;
field_composer       :   C  ANY_TEXT_STRING eol;
ifield_composer      :  IC  ANY_TEXT_IFIELD;
field_discography    :   D  ANY_TEXT_STRING eol;
ifield_discography   :  ID  ANY_TEXT_IFIELD;
field_file           :   F  ANY_TEXT_STRING eol;
field_group          :   G  ANY_TEXT_STRING eol;
ifield_group         :  IG  ANY_TEXT_IFIELD;
field_history        :   H  ANY_TEXT_STRING eol;
ifield_history       :  IH  ANY_TEXT_IFIELD;
field_instruction    :   I  instruction eol;
ifield_instruction   :  II  iinstruction;
field_key            :   K  key eol;
ifield_key           :  IK  key RBPAREN;
field_length         :   L  note_length_strict eol;
ifield_length        :  IL  note_length_strict;
header_field_meter   :   M  time_signature eol;
field_meter          :   M  time_signature eol;
ifield_meter         :  IM  time_signature;
field_notes          :   N  ANY_TEXT_STRING eol;
ifield_notes         :  IN  ANY_TEXT_IFIELD;
field_origin         :   O  ANY_TEXT_STRING eol;
ifield_origin        :  IO  ANY_TEXT_IFIELD;
field_parts          :   P  parts_play_order eol;
field_part           :   P  PART_NUMBER eol;
ifield_part          :  IP  PART_NUMBER;
field_tempo          :   Q  tempo_def eol;
ifield_tempo         :  IQ  tempo_def;
field_rhythm         :   R  ANY_TEXT_STRING eol;
ifield_rhythm        :  IR  ANY_TEXT_IFIELD;
field_source         :   S  ANY_TEXT_STRING eol;
ifield_source        :  IS  ANY_TEXT_IFIELD;
field_userdef_print  :   U  userdef eol;
field_userdef_play   :  FU  userdef eol;
field_voice          :   V  voice eol;
ifield_voice         :  IV  voiceref;
field_words          :   W  ANY_TEXT_STRING eol;
ifield_words         :  IW  ANY_TEXT_IFIELD;
field_transcription  :   Z  ANY_TEXT_STRING eol;
ifield_transcription :  IZ  ANY_TEXT_IFIELD;
field_macro          :  FM  ANY_TEXT_STRING eol;
field_lyrics         :  FW  lyrics eol;
ifield_lyrics        : IFW ANY_TEXT_IFIELD;
/*unused_field         :     UNUSED COLON any_text_string eol;
unused_ifield        : LBPAREN UNUSED COLON any_text_ifield RBPAREN; */

/* -------------------------------------------------------------------------------- */

time_signature     : TIME_SIG | NONE | meter_num | INTEGER;
meter_sums         : INTEGER (PLUS INTEGER)*;
meter_numerator    : (LPAREN meter_sums RPAREN) | meter_sums;
meter_num          : meter_numerator SLASH INTEGER ( meter_num)?;                                             /* e.g. 2|4  6|8  2+2+3|16  11|8  2|4 3|4  2+2+3|8 2+2+3+2+2+2|8 */
tempo_def          : ((string_double_quote? tempo string_double_quote?) | string_double_quote);
tempo              : (note_length_strict ( note_length_strict)* EQUAL INTEGER) | (C EQUAL INTEGER) | INTEGER; /* e.g. 'adagio' 1|4=60 1|4 3|8 1|4 3|8 = 80 'allegro' 1|4=120 'con brio' */
note_length_strict : INTEGER SLASH INTEGER;
key                : clef | (key_def ( clef)?) | HP;
key_def            : key_pitch (modus)? ( global_accidental)*;
key_pitch          : basenote (HASH | SMALL_B)?;
modus              : MAJOR | LYDIAN | IONIAN | MIXOLYDIAN | DORIAN | AEOLIAN | PHRYGIAN | LOCRIAN | MINOR;
global_accidental  : accidental basenote; /* e.g. ^f =c _b */
parts_play_order   : ((LETTER INTEGER) | LETTER | DOT | ((LPAREN parts_play_order RPAREN) INTEGER) | (LPAREN parts_play_order RPAREN))+;

/* -------------------------------------------------------------------------------- */

voice           : voiceref ( (clef | voice_name | voice_subname | voice_transpose | voice_stave | VOICE_MERGE | stem_dir | voice_prop_str | voice_prop_int ))*;
voiceref        : (LETTER | INTEGER)+;
voice_name      : VOICE_NAME EQUAL string_double_quote;
voice_subname   : VOICE_SUBNAME EQUAL string_double_quote;
voice_transpose : VOICE_TRANSPOSE EQUAL SIGNED_INTEGER;
voice_stave     : VOICE_STAVE EQUAL INTEGER;
voice_prop_str  : NORM_STRING EQUAL string_double_quote;
voice_prop_int  : NORM_STRING EQUAL SIGNED_INTEGER;
stem_dir        : (STEM EQUAL)? STEM_DIR_VALUE;
clef            : ((CLEF EQUAL (CLEF_NOTE | CLEF_NAME | clef_unknown)) | CLEF_NAME) INTEGER? CLEF_OCTAVE? ( clef_attributes)*;
clef_unknown    : LETTER+;
clef_attributes : clef_middle | clef_transpose | clef_stafflines;
clef_middle     : MIDDLE? EQUAL clef_pitch;
clef_transpose  : TRANSPOSE? EQUAL SIGNED_INTEGER;
clef_stafflines : STAFFLINES? EQUAL INTEGER;
clef_pitch      : basenote (HASH | SMALL_B)? OCTAVE?;

/* -------------------------------------------------------------------------------- */

userdef         : USERDEF_SYMBOL EQUAL (LONG_DECORATION | chord_or_text);

/* -------------------------------------------------------------------------------- */
/*
# 4.20. Order of ABC constructs
#
# The order of ABC constructs is: <grace notes> <chord symbols>
# <annotations>|<decorations> (e.g. Irish roll staccato marker or
# up|downbow) <accidentals> <note> <OCTAVE> ''<note length>''
# i.e. ~^c'3 or even 'Gm7'v.=G2.
#
# Tie symbols MINUS should come immediately after a note group but may
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

element           : inline_field | barline | broken_rhythm |
                     stem | chord_or_text | grace_notes |
                     tuplet_start | VOICE_OVER_START |
                     VOICE_OVER_END | VOICE_OVER_ROLLBACK |
                     slur_begin | slur_end | HARD_LINE_BREAK |
                     multi_measure_rest | measure_repeat | nth_repeat |
                     end_nth_repeat | unused_char;

barline           : decorations? (INVISIBLE_BARLINE | (COLON* LBPAREN* PIPE+ RBPAREN* (COLON+ | nth_repeat_num)?) | dashed_barline); /* e.g. :| | |:: |2 :||: */

dashed_barline    : COLON;

/* -------------------------------------------------------------------------------- */

stem            : decorations? (singlenote | stemchord | rest | spacer);
singlenote      : note;
stemchord       : LBPAREN note note+ RBPAREN note_length? tie?;
note            : WSP? pitch note_length? tie? WSP?;
pitch           : accidental? basenote OCTAVE?;
rest            : (normal_rest | invisible_rest ) note_length?;
normal_rest     : SZ;
invisible_rest  : SX;
spacer          : SY;
accidental      : POW POW? | UNDERSCORE UNDERSCORE? | EQUAL;
note_length     : (INTEGER (SLASH INTEGER)?) | (SLASH INTEGER) | SLASH+;
tie             : DOT? MINUS;

/* -------------------------------------------------------------------------------- */

broken_rhythm   : stem b_elem* broken_type b_elem* stem;
broken_type     : LT+ | GT+;
b_elem          : WSP | LC | chord_or_text | decorations | grace_notes | slur_begin | slur_end;
tuplet_start    : decorations? tuplet_num (tuplet_into tuplet_notes?)?;
tuplet_num      : LPAREN INTEGER;
tuplet_into     : COLON INTEGER?;
tuplet_notes    : COLON INTEGER?;

/* -------------------------------------------------------------------------------- */

decorations     : decoration+;
decoration      : DOT | USERDEF_SYMBOL | LONG_DECORATION;
grace_notes     : LCBRACK acciaccatura? grace_note_stem+ RCBRACK;
grace_note_stem : grace_note | (LBPAREN grace_note grace_note+ RBPAREN);
grace_note      : pitch note_length?;
acciaccatura    : SLASH;

/* -------------------------------------------------------------------------------- */

chord_or_text    : QUOTE (chord | text_expression) ((EOL | HASH) (chord | text_expression))* QUOTE;
chord            : decorations? basenote chord_accidental? chord_type? (SLASH basenote chord_accidental?)? non_quote*;
chord_accidental : HASH | SMALL_B | EQUAL;
chord_type       : (LETTER | DIGIT | PLUS | MINUS)+;
text_expression  : (POW | LT | GT | UNDERSCORE | AT)? non_quote+;

/* -------------------------------------------------------------------------------- */

slur_begin           : DOT? LPAREN;
slur_end             : DOT? RPAREN;

measure_repeat       : SLASH SLASH?;
multi_measure_rest   : decorations? Z INTEGER?;

nth_repeat           : LBPAREN (nth_repeat_num | nth_repeat_text);
nth_repeat_num       : INTEGER (MINUS? DIGITS)*;
nth_repeat_text      : string_double_quote;
end_nth_repeat       : RBPAREN;

unused_char          : HASH | DOLLAR | TIMES | PLUS | HASH | QUESTION | AT | TICK;

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

inst_abc_copyright   : ABC_COPYRIGHT  ANY_TEXT_STRING;
iinst_abc_copyright  : ABC_COPYRIGHT  ANY_TEXT_IFIELD;
inst_abc_version     : ABC_VERSION  DIGITS (DOT DIGITS)*;
iinst_abc_version    : inst_abc_version;
inst_abc_creator     : ABC_CREATOR  ANY_TEXT_STRING;
iinst_abc_creator    : ABC_CREATOR  ANY_TEXT_IFIELD;
inst_abc_charset     : ABC_CHARSET  ANY_TEXT_STRING;
iinst_abc_charset    : ABC_CHARSET  ANY_TEXT_IFIELD;
inst_abc_edited_by   : ABC_EDITED_BY  ANY_TEXT_STRING;
iinst_abc_edited_by  : ABC_EDITED_BY  ANY_TEXT_IFIELD;
inst_staff           : inst_staffbreak | inst_multicol | inst_staves | inst_indent;
iinst_staff          : inst_staff;
inst_measurenb       : MEASURENB | MEASUREBOX | MEASUREFIRST | (SETBARNB  DIGITS);
iinst_measurenb      : inst_measurenb;
inst_text            : inst_textline | inst_textcenter | inst_textblock;
iinst_text           : iinst_textline | iinst_textcenter | iinst_textblock;
inst_textline        : TEXT  ANY_TEXT_STRING;
iinst_textline       : TEXT  ANY_TEXT_IFIELD;
inst_textcenter      : CENTER  ANY_TEXT_STRING;
iinst_textcenter     : CENTER  ANY_TEXT_IFIELD;
inst_textblock       : BEGINTEXT ( TEXTBLOCK_PARAM)? eol
                        (I ? (ENDTEXT eol) ANY_TEXT_STRING eol)*
                        I ENDTEXT;
iinst_textblock      : BEGINTEXT ( TEXTBLOCK_PARAM)? RBPAREN
                        (II ? (ENDTEXT RBPAREN) ANY_TEXT_IFIELD RBPAREN )*
                        II ENDTEXT;
inst_layout          : inst_sep | inst_vskip | inst_newpage;
iinst_layout         : inst_layout;
inst_margins         : (BOTMARGIN | TOPMARGIN | LEFTMARGIN | RIGHTMARGIN)  midi_float inst_unit;
iinst_margins        : inst_margins;
inst_other           : ANY_TEXT_STRING;
iinst_other          : ANY_TEXT_IFIELD;

inst_unit            : INST_UNIT?;

inst_staffbreak      : STAFFBREAK  midi_float inst_unit;
inst_multicol        : MULTICOL  (START | NEW | END);
inst_staves          : STAVES  stave_voice (bar_staves? stave_voice)*;
stave_voice          : single_voice | bracketed_voice | braced_voice | paren_voice;
bracketed_voice      : LBPAREN (single_voice | braced_voice | paren_voice)
                         (bar_staves? (single_voice | braced_voice | paren_voice))+ RBPAREN; /* staves joined by bracket */
braced_voice         : LCBRACK (single_voice | paren_voice)
                         (bar_staves? (single_voice | paren_voice))+ RCBRACK; /* staves joined by brace */
paren_voice          : LPAREN single_voice (bar_staves? single_voice)+ RPAREN; /* on same staff */
single_voice         : TIMES? (LETTER | DIGIT)+;
bar_staves           : PIPE ;
inst_indent          : INDENT  midi_float inst_unit;
inst_sep             : SEP (( midi_float inst_unit) ( midi_float inst_unit) ( midi_float inst_unit))?;
                        /* space_above space_below width */
inst_vskip           : VSKIP  midi_float inst_unit;
inst_newpage         : NEWPAGE ( DIGITS)?; /* optionally restart page numbering at n */

inst_midi            : MIDI  (midi_channel | midi_program | midi_transpose | midi_control | midi_voice | midi_instrument | midi_mute | midi_chordprog )+;
iinst_midi           : inst_midi;
midi_channel         : CHANNEL (EQUAL ) |  MIDI_CHANNEL_NUMBER ;
midi_program         : PROGRAM (EQUAL ) |  (MIDI_CHANNEL_NUMBER (COMMA ) |  midi_program_number) | midi_program_number ;
midi_control         : CONTROL (EQUAL ) |  (INTEGER (EQUAL ) |  INTEGER) | midi_control_int | midi_control_bool ;
midi_program_number  : MP_NUM | MIDI_PROGRAM_NAME;
midi_transpose       : TRANSPOSE (EQUAL ) |  SIGNED_INTEGER ;
midi_voice           : VOICE (EQUAL ) |  midi_voiceref ;
midi_voiceref        : (LETTER | DIGIT)+;
midi_instrument      : INSTRUMENT (EQUAL ) |  midi_program_number (midi_bank)? ;
midi_bank            : BANK (EQUAL ) |  INTEGER ;
midi_mute            : MUTE ;
midi_chordprog       : CHORDPROG (EQUAL ) |  midi_program_number ;
midi_control_int     : midi_control_volume | midi_control_balance | midi_control_pan;
midi_control_volume  : VOLUME (EQUAL ) |  (INTEGER | MIDI_VOLUME_LABEL);
midi_control_balance : BALANCE (EQUAL ) |  (INTEGER | MIDI_PAN_LABEL);
midi_control_pan     : PAN (EQUAL ) |  (INTEGER | MIDI_PAN_LABEL);
midi_control_bool    : MIDI_BOOL_NAME (EQUAL ) |  BOOL;
midi_float           : (DIGITS (DOT DIGITS)?) | (DOT DIGITS);

/* -------------------------------------------------------------------------------- */

lyrics                : (lyrics_char | lyrics_syllable_break | lyrics_next_bar |
                         lyrics_hold | lyrics_skip_note | lyrics_nbsp | lyrics_dash |
                         tex_escape)*;
lyrics_ifield         : (lyrics_char_ifield | lyrics_syllable_break |
                         lyrics_next_bar | lyrics_hold | lyrics_skip_note |
                         lyrics_nbsp | lyrics_dash | tex_escape)*;
lyrics_syllable_break : L_MINUS; /* break between syllables in a word */
lyrics_next_bar       : L_PIPE; /* advance to next bar */
lyrics_hold           : L_UNDERSCORE; /* hold syllable for one more note */
lyrics_skip_note      : L_TIMES; /* =blank syllable */
lyrics_nbsp           : L_TILDE; /* non_breaking space = words on same note */
lyrics_dash           : L_LDASH; /* printed as a - */
lyrics_char_ifield    : L_WSP_INTERNAL | L_DIGIT | L_LETTER | L_SPECIAL | L_LX1;
                         /* all characters without special meaning and except RBPAREN */
lyrics_char           : lyrics_char_ifield | L_RBPAREN;
                         /* all characters without special meaning */

/* -------------------------------------------------------------------------------- */

basenote        : BASENOTE | SMALL_B;
string_double_quote: QUOTE non_quote QUOTE;
non_quote       : (WSP_INTERNAL | LX2);       /* all non_eol characters except double quote */
any_text        : (WSP_INTERNAL | SPECIAL | LX3); /* any printable character plus all non_eol whitespace */
tex_escape      : BACKSLASH (DIGIT | LETTER | UNDERSCORE)+;     /* tex line - for backward compatability */

/* -------------------------------------------------------------------------------- */

comment : COMMENT_START COMMENT?;
eol     : comment? EOL;

/* -------------------------------------------------------------------------------- */
