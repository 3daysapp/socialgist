import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialgist/model/Gist.dart';

///
///
///
class CodeHighlight extends StatelessWidget {
  final File file;
  final double height;

  ///
  ///
  ///
  const CodeHighlight(this.file, {this.height, Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    String lang;
    int tabSize = 4;

    switch (file.type) {
      case 'application/javascript':
        lang = 'javascript';
        break;
      case 'text/x-java-source':
        lang = 'java';
        break;
      case 'application/x-python':
        lang = 'python';
        break;
    }

    if (lang == null && file.language != null) {
      switch (file.language) {
        case 'C++':
        case 'C':
          lang = 'cpp';
          break;
        case 'PLpgSQL':
          lang = 'sql';
          break;
        case 'HTML':
          lang = 'xml';
          break;
      }

      if (lang == null) {
        String tempLang = file.language.toLowerCase();
        if (languages.contains(tempLang)) {
          lang = tempLang;
        }
      }
    }

    String content;
    if (file.content.length < 500) {
      content = file.content;
    } else {
      content = file.content.substring(0, 500) + ' {...}';
    }

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.white24,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: HighlightView(
          content,
          language: lang ?? 'plaintext',
          theme: myTheme,
          textStyle: GoogleFonts.firaMono(fontSize: 12.0),
          tabSize: tabSize,
        ),
      ),
    );
  }

  ///
  ///
  ///
  static const myTheme = {
    'root': TextStyle(
      color: Color(0xffa9b7c6),
      backgroundColor: Color(0x00000000),
    ),
    'number': TextStyle(color: Color(0xff6897BB)),
    'literal': TextStyle(color: Color(0xff6897BB)),
    'symbol': TextStyle(color: Color(0xff6897BB)),
    'bullet': TextStyle(color: Color(0xff6897BB)),
    'keyword': TextStyle(color: Color(0xffcc7832)),
    'selector-tag': TextStyle(color: Color(0xffcc7832)),
    'deletion': TextStyle(color: Color(0xffcc7832)),
    'variable': TextStyle(color: Color(0xff629755)),
    'template-variable': TextStyle(color: Color(0xff629755)),
    'link': TextStyle(color: Color(0xff629755)),
    'comment': TextStyle(color: Color(0xff808080)),
    'quote': TextStyle(color: Color(0xff808080)),
    'meta': TextStyle(color: Color(0xffbbb529)),
    'string': TextStyle(color: Color(0xff6A8759)),
    'attribute': TextStyle(color: Color(0xff6A8759)),
    'addition': TextStyle(color: Color(0xff6A8759)),
    'section': TextStyle(color: Color(0xffffc66d)),
    'title': TextStyle(color: Color(0xffffc66d)),
    'type': TextStyle(color: Color(0xffffc66d)),
    'name': TextStyle(color: Color(0xffe8bf6a)),
    'selector-id': TextStyle(color: Color(0xffe8bf6a)),
    'selector-class': TextStyle(color: Color(0xffe8bf6a)),
    'emphasis': TextStyle(fontStyle: FontStyle.italic),
    'strong': TextStyle(fontWeight: FontWeight.bold),
  };

  ///
  ///
  ///
  static const languages = [
    '1c',
    'abnf',
    'accesslog',
    'actionscript',
    'ada',
    'angelscript',
    'apache',
    'applescript',
    'arcade',
    'arduino',
    'armasm',
    'asciidoc',
    'aspectj',
    'autohotkey',
    'autoit',
    'avrasm',
    'awk',
    'axapta',
    'bash',
    'basic',
    'bnf',
    'brainfuck',
    'cal',
    'capnproto',
    'ceylon',
    'clean',
    'clojure',
    'clojure-repl',
    'cmake',
    'coffeescript',
    'coq',
    'cos',
    'cpp',
    'crmsh',
    'crystal',
    'cs',
    'csp',
    'css',
    'd',
    'dart',
    'delphi',
    'diff',
    'django',
    'dns',
    'dockerfile',
    'dos',
    'dsconfig',
    'dts',
    'dust',
    'ebnf',
    'elixir',
    'elm',
    'erb',
    'erlang',
    'erlang-repl',
    'excel',
    'fix',
    'flix',
    'fortran',
    'fsharp',
    'gams',
    'gauss',
    'gcode',
    'gherkin',
    'glsl',
    'gml',
    'go',
    'golo',
    'gradle',
    'groovy',
    'haml',
    'handlebars',
    'haskell',
    'haxe',
    'hsp',
    'htmlbars',
    'http',
    'hy',
    'inform7',
    'ini',
    'irpf90',
    'isbl',
    'java',
    'javascript',
    'jboss-cli',
    'json',
    'julia',
    'julia-repl',
    'kotlin',
    'lasso',
    'ldif',
    'leaf',
    'less',
    'lisp',
    'livecodeserver',
    'livescript',
    'llvm',
    'lsl',
    'lua',
    'makefile',
    'markdown',
    'mathematica',
    'matlab',
    'maxima',
    'mel',
    'mercury',
    'mipsasm',
    'mizar',
    'mojolicious',
    'monkey',
    'moonscript',
    'n1ql',
    'nginx',
    'nimrod',
    'nix',
    'nsis',
    'objectivec',
    'ocaml',
    'openscad',
    'oxygene',
    'parser3',
    'perl',
    'pf',
    'pgsql',
    'php',
    'plaintext',
    'pony',
    'powershell',
    'processing',
    'profile',
    'prolog',
    'properties',
    'protobuf',
    'puppet',
    'purebasic',
    'python',
    'q',
    'qml',
    'r',
    'reasonml',
    'rib',
    'roboconf',
    'routeros',
    'rsl',
    'ruby',
    'ruleslanguage',
    'rust',
    'sas',
    'scala',
    'scheme',
    'scilab',
    'scss',
    'shell',
    'smali',
    'smalltalk',
    'sml',
    'sqf',
    'sql',
    'stan',
    'stata',
    'step21',
    'stylus',
    'subunit',
    'swift',
    'taggerscript',
    'tap',
    'tcl',
    'tex',
    'thrift',
    'tp',
    'twig',
    'typescript',
    'vala',
    'vbnet',
    'vbscript',
    'vbscript-html',
    'verilog',
    'vhdl',
    'vim',
    'x86asm',
    'xl',
    'xml',
    'xquery',
    'yaml',
    'zephir',
  ];
}
